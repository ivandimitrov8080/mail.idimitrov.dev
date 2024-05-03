{
  services.wordpress = {
    webserver = "nginx";
    sites = {
      "cms.idimitrov.dev" = {
        settings = {
          WP_DEBUG = true;
        };
      };
    };
  };
}
