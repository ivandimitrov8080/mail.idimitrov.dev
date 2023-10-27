{ config, pkgs, ... }:
{

  imports = [ ./configuration.nix ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  mailserver = {
    fqdn = "mail.idimitrov.dev";
    domains = [ "idimitrov.dev" "mail.idimitrov.dev" ];

    loginAccounts = {
      "ivan@idimitrov.dev" = {
        hashedPassword = "$2b$05$rTVIQD98ogXeCBKdk/YufulWHqpMCAlb7SHDPlh5y8Xbukoa/uQLm";
        aliases = [ "admin@idimitrov.dev" ];
      };
      "security@idimitrov.dev" = {
        hashedPassword = "$2b$05$rTVIQD98ogXeCBKdk/YufulWHqpMCAlb7SHDPlh5y8Xbukoa/uQLm";
      };
    };

    certificateScheme = "acme-nginx";
    hierarchySeparator = "/";
  };

  security = {
    acme = {
      acceptTerms = true;
      defaults.email = "security@idimitrov.dev";
      certs = {
        "mail.idimitrov.dev" = {
          listenHTTP = ":80";
        };
        "idimitrov.dev" = {
          listenHTTP = ":80";
        };
      };
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
    systemPackages = with pkgs; [ coreutils-full fd git vim mlocate busybox bash ];
  };
}
