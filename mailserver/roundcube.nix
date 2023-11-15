{ config, pkgs, ... }:
{
  services = {
    roundcube = {
      enable = true;
      hostName = "${config.mailserver.fqdn}";
      extraConfig = ''
        $config['smtp_host'] = "tls://${config.mailserver.fqdn}";
        $config['smtp_user'] = "%u";
        $config['smtp_pass'] = "%p";
      '';
    };
    nginx.enable = true;
  };
}
