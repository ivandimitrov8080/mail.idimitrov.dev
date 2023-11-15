{ config, pkgs, ... }:
{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "roundcube" ];
      ensureUsers = [
        {
          name = "roundcube";
          ensurePermissions = {
            "DATABASE \"roundcube\"" = "ALL PRIVILEGES";
            "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
            "ALL SEQUENCES IN SCHEMA public" = "ALL PRIVILEGES";
            "SCHEMA public" = "ALL PRIVILEGES";
          };
        }
        {
          name = "root";
          ensureClauses = {
            superuser = true;
            createrole = true;
            createdb = true;
          };
        }
      ];
      initialScript = pkgs.writeText "init" ''
        GRANT ALL PRIVILEGES ON DATABASE roundcube TO roundcube;
        GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO roundcube;
        GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO roundcube;
        GRANT ALL PRIVILEGES ON SCHEMA public TO roundcube;
      '';
    };
  };
}
