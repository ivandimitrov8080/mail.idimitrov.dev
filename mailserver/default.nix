{ config, pkgs, ... }:
{
  imports = [ ./configuration.nix ./mailserver ./roundcube ./postgres ./wireguard ./nginx ./webshite ./tor ./i2pd ./gitea ];
}
