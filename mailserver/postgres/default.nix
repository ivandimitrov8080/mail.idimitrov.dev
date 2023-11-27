{ config, pkgs, ... }:
{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "roundcube" ];
      ensureUsers = [
        {
          name = "roundcube";
          ensureDBOwnership = true;
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
