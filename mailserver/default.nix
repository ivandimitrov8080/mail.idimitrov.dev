{ config, pkgs, ... }:
{
  imports = [ ./configuration.nix ./mailserver.nix ./roundcube.nix ./postgres.nix ./wireguard.nix ];
}
