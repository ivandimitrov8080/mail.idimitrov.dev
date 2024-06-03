{ pkgs, ... }:
{
  time.timeZone = "Europe/Prague";
  system.stateVersion = "23.11";

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  security = {
    acme = {
      acceptTerms = true;
      defaults.email = "security@idimitrov.dev";
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53 80 443 ];
      allowedUDPPorts = [ 53 51820 ];
    };
    stevenBlackHosts = {
      enable = true;
      blockFakenews = true;
      blockGambling = true;
    };
  };

  users = {
    users.ivand = {
      isNormalUser = true;
      hashedPassword =
        "$2b$05$hPrPcewxj4qjLCRQpKBAu.FKvKZdIVlnyn4uYsWE8lc21Jhvc9jWG";
      extraGroups = [ "wheel" "adm" "mlocate" ];
      openssh.authorizedKeys.keys = [
        ''
          ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyW157tNiQdeoQsoo5AEzhyi6BvPeqEvChCxCHf3hikmFDqb6bvvlKYb9grW+fqE0HzALRwpXvPKnuUwHKPVG8HZ7NC9bT5RPMO0rFviNoxWF2PNDWG0ivPmLrQGKtCPM3aUIhSdUdlJ7ImYl34KBkUIrSmL7WlLJUvh1PtyyuVfrhpFzFxHwYwVCNO33L89lfl5PY/G9qrjlH64urt/6aWqMdHD8bZ4MHBPcnSwLMd7f0nNa0aTAJMabsfmndZhV24y7T1FUWG0dl27Q4rnpnZJWBDD1IyWIX/aN+DD6eVVWa4tRVJs6ycfw48hft0zs9zLn9mU4a2hxQ6VvfwpqZHOO8XqqOSai9Yw9Ba60iVQokQQiL91KidoSF7zD0U0szdEmylANyAntUcJ1kdu496s21IU2hjYfN/3seH5a9hBk8iPHp/eTeVUXFKh27rRWn0gc+rba1LF0BWfTjRYR7e1uvPEau0I61sNsp3lnMULdkgkZ9rap1sRM6ULlaRXM= ivand@nixos
        ''
      ];
    };
    extraGroups = { mlocate = { }; };
  };

  environment = {
    systemPackages = with pkgs; [ nmap coreutils-full fd git vim mlocate busybox bash scripts ];
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
      };
    };
  };
  systemd = {
    timers = {
      bingwp = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "*-*-* 10:00:00";
          Persistent = true;
        };
      };
    };
    services = {
      bingwp = {
        description = "Download bing image of the day";
        script = ''
          ${pkgs.nushell}/bin/nu -c "http get ('https://bing.com' + ((http get https://www.bing.com/HPImageArchive.aspx?format=js&n=1).images.0.url)) | save  ('/var/pic' | path join ( [ (date now | format date '%Y-%m-%d'), '.png' ] | str join ))"
        '';
      };
    };
  };
}
