{
  inputs = {
    nixpkgs.url = "nixpkgs";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpsadminos.url = "github:vpsfreecz/vpsadminos";
  };

  outputs =
    { self
    , nixpkgs
    , simple-nixos-mailserver
    , vpsadminos
    , ...
    }:
    let
      myOverlay = self: super: {
        scripts = (super.buildEnv { name = "scripts"; paths = [ ./. ]; });
      };

    in
    {
      nixosConfigurations = {
        mailserver = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
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
