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
    minetest-server = {
      enable = true;
      port = 30000;
      gameId = "mineclone2";
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 30000 ];
    allowedUDPPorts = [ 30000 ];
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
