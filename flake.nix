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
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      config = config;
      nvidia = ./modules/system/nvidia.nix;

      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            (./. + "/hosts/${hostname}/system.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager =  {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.maltalef = ( import (./. + "/hosts/${hostname}/maltalef.nix") { inherit inputs lib config; });
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

    in {
      nixosConfigurations = {
        c64 = mkSystem inputs.nixpkgs "x86_64-linux" "c64";
		c128 = mkSystem inputs.nixpkgs "x86_64-linux" "c128";
    };
  };
}
