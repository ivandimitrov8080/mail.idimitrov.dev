{ config, pkgs, lib, ... }:
{

  website.enable = true;
  mailserver.enable = true;
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
      };
    };
  };
  #users.extraUsers.root.openssh.authorizedKeys.keys =
  #  [ "..." ];

  systemd = {
    services = {
      "serial-getty@ttyS0".enable = lib.mkForce false;
    };
    extraConfig = ''
      DefaultTimeoutStartSec=900s
    '';
  };

  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "23.05";
}
