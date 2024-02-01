{ pkgs, ... }:
let
  webshiteConfig = ''
    add_header 'Referrer-Policy' 'origin-when-cross-origin';
    add_header X-Content-Type-Options nosniff;
    add_header Onion-Location http://sxfx23zafag4lixkb4s6zwih7ga5jnzfgtgykcerd354bvb6u7alnkid.onion;
  '';
in
{
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
      virtualHosts = {
        "idimitrov.dev" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000";
          };
          extraConfig = webshiteConfig;
        };
        "www.idimitrov.dev" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000";
          };
          extraConfig = webshiteConfig;
        };
        "src.idimitrov.dev" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3001";
          };
        };
      };
    };
  };
}

