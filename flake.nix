{
  inputs = {
    nixpkgs.url = "nixpkgs";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    "idimitrov-dev" = {
      url = "git+ssh://git@gitlab.com/ivandimitrov8080/idimitrov.dev.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , simple-nixos-mailserver
    , idimitrov-dev
    , ...
    }: {
      nixosConfigurations = {
        mailserver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            simple-nixos-mailserver.nixosModule
            idimitrov-dev.nixosModules.x86_64-linux.default
            ./mailserver
          ];
        };
      };
    };
}
