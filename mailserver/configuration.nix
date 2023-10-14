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
  systemd = {
    services = {
      "serial-getty@ttyS0".enable = lib.mkForce false;
    };
    extraConfig = ''
      DefaultTimeoutStartSec=900s
    '';
  };
  time.timeZone = "Europe/Sofia";
  system.stateVersion = "23.11";
}
