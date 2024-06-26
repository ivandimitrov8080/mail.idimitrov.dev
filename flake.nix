{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    webshite = {
      url = "github:ivandimitrov8080/idimitrov.dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpsadminos.url = "github:vpsfreecz/vpsadminos";
    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , simple-nixos-mailserver
    , vpsadminos
    , webshite
    , hosts
    , ...
    }:
    let
      system = "x86_64-linux";
      myOverlay = final: prev: {
        scripts = (final.buildEnv { name = "scripts"; paths = [ ./. ]; });
        webshite = webshite.packages.${system}.default;
      };

    in
    {
      nixosConfigurations = {
        inherit system;
        mailserver = nixpkgs.lib.nixosSystem {
          modules = [
            vpsadminos.nixosConfigurations.container
            simple-nixos-mailserver.nixosModule
            hosts.nixosModule
            ./mailserver
          ];
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ myOverlay ];
          };
        };
      };
    };
}
