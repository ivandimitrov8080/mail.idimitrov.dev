{ pkgs, ... }:
{
  systemd.services.webshite = {
    enable = true;
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${pkgs.webshite}/bin/idimitrov.dev";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
  systemd.services.pic = {
    enable = true;
    serviceConfig = {
      ExecStart = "${pkgs.pic}/bin/pic";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
