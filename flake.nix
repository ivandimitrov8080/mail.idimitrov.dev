{
  inputs = {
    nixpkgs.url = "nixpkgs";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    webshite = {
      url = "github:ivandimitrov8080/idimitrov.dev/nextjs_standalone";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpsadminos.url = "github:vpsfreecz/vpsadminos";
  };

  outputs =
    { self
    , nixpkgs
    , simple-nixos-mailserver
    , vpsadminos
    , webshite
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
            simple-nixos-mailserver.nixosModule
            vpsadminos.nixosConfigurations.container
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
