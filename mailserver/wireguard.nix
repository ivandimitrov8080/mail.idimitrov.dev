{ pkgs, ... }: {
  networking = {
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
    firewall = {
      allowedUDPPorts = [ 51820 ];
    };
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
        '';
        privateKeyFile = "/etc/wireguard/privatekey";
        generatePrivateKeyFile = true;
        peers = [
          {
            publicKey = "28yXYLk4U0r6MdWFEZzk6apI8uhg962wMprF47wUJyI=";
            allowedIPs = [ "10.100.0.2/32" ];
          }
        ];
      };
    };
  };


}
