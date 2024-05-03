{ pkgs, ... }:
{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "root" "roundcube" "gitea" ];
      ensureUsers = [
        {
          name = "roundcube";
          ensureDBOwnership = true;
        }
        {
          name = "gitea";
          ensureDBOwnership = true;
        }
        {
          name = "root";
          ensureDBOwnership = true;
          ensureClauses = {
            superuser = true;
            createrole = true;
            createdb = true;
          };
        }
      ];
      authentication = ''
        #type   database    DBuser        auth-method
        local   gitea       all           ident         map=gitea-users
      '';
      identMap = ''
        gitea-users gitea gitea
      '';
      initialScript = pkgs.writeText "init" ''
        GRANT ALL PRIVILEGES ON DATABASE roundcube TO roundcube;
        GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO roundcube;
        GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO roundcube;
        GRANT ALL PRIVILEGES ON SCHEMA public TO roundcube;
      '';
    };
  };
}
