{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-dots.url = "github:Ludofr3/hyprland-dotfiles";
    hyprland-dots.flake = false; # C'est un depot de dotfile, pas un Flake
  };

  outputs = { self, nixpkgs, home-manager,  ...}@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        home-manager.nixosModules.default # Active Home Manager
        ./home.nix
      ];
    };    
  };
}
