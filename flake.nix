{
  inputs = {
    nixpkgs.url = "nixpkgs";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpsadminos.url = "github:vpsfreecz/vpsadminos";
    webshite = {
      url = "github:ivandimitrov8080/idimitrov.dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , simple-nixos-mailserver
    , vpsadminos
    , webshite
    , ...
    }: {
      nixosConfigurations = {
        mailserver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            simple-nixos-mailserver.nixosModule
            vpsadminos.nixosConfigurations.container
            webshite.nixosModules.default
            ./mailserver
          ];
        };
      };
    };
}
