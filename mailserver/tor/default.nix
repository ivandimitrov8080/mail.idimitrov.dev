{
  services.tor = {
    enable = true;
    relay.onionServices = {
      idimitrov = {
        map = [{
          port = 80;
          target = {
            addr = "127.0.0.1";
            port = 3000;
          };
        }];
      };
    };
  };
}
