{
  inputs = {
    nixpkgs.url = "nixpkgs";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    webshite = {
      url = "git+https://src.idimitrov.dev/ivan/idimitrov.dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpsadminos.url = "github:vpsfreecz/vpsadminos";
    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
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
        mailserver = nixpkgs.lib.nixosSystem rec {
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
