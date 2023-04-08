{
  description = "maltalef's NixOS configuration";

  inputs =  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, ... } @inputs: 
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;
      config = config;

      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            ./modules/system/configuration.nix
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager =  {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.maltalef = ( import (./. + "/hosts/${hostname}/user.nix") { inherit inputs lib config; });
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

    in {
      nixosConfigurations = {
        c64 = mkSystem inputs.nixpkgs "x86_64-linux" "c64";
    };
  };
}
