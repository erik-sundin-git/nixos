{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim.url = "github:erik-sundin-git/neovim";
  };

  outputs = { self, nixpkgs,neovim, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
	  inherit inputs;
	};
      modules = [
        ./config.nix
      ];
    };
  };
}
