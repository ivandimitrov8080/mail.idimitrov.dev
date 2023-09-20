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
    }: {
      nixosConfigurations = {
        mailserver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            simple-nixos-mailserver.nixosModule
            vpsadminos.nixosConfigurations.container
            ./mailserver
          ];
        };
      };
    };
}
