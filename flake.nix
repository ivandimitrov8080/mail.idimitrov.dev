{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    vpsadminos.url = "github:vpsfreecz/vpsadminos";
    conf = { url = "github:ivandimitrov8080/configuration.nix"; inputs = { nixpkgs.follows = "nixpkgs"; }; };
    simple-nixos-mailserver = { url = "gitlab:simple-nixos-mailserver/nixos-mailserver"; inputs.nixpkgs.follows = "nixpkgs"; };
    webshite = { url = "github:ivandimitrov8080/idimitrov.dev"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs =
    { nixpkgs
    , vpsadminos
    , conf
    , simple-nixos-mailserver
    , webshite
    , ...
    }:
    let
      system = "x86_64-linux";
      myOverlay = final: prev: {
        webshite = webshite.packages.${system}.default;
      };
      mods = conf.nixosModules;
    in
    {
      nixosConfigurations = {
        inherit system;
        mailserver = nixpkgs.lib.nixosSystem {
          modules = [
            vpsadminos.nixosConfigurations.container
            simple-nixos-mailserver.nixosModule
            mods.base
            mods.shell
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
