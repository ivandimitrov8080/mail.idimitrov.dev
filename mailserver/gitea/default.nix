{ config, pkgs, ... }:
{
  services.gitea = {
    enable = true;
    appName = "idimitrov: Gitea";
    database = {
      type = "postgres";
    };
    settings = {
      server = {
        DOMAIN = "git.idimitrov.dev";
        ROOT_URL = "https://git.idimitrov.dev/";
        HTTP_PORT = 3001;
      };
    };
  };
}
