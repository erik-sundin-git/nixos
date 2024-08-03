{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-patched.url = "github:erik-sundin-git/nixpkgs?ref=picom-ftlabs";

    neovim.url = "github:erik-sundin-git/neovim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-patched,
    neovim,
    ...
  } @ inputs: let
    systemSettings = {
      system = "x86_64-linux"; # system arch
    };
    pkgs-stable = import nixpkgs-stable {
      system = systemSettings.system;
      config.allowUnfree = true;
    };

    pkgs-patched = import nixpkgs-patched {
      system = systemSettings.system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
      system = systemSettings.system;
      specialArgs = {
        inherit inputs;
        inherit pkgs-stable;
        inherit pkgs-patched;
      };
      modules = [
        ./nixos/config.nix
        ./nixos/hosts/yoga/default.nix
        ./nixos/modules/default.nix
      ];
    };
  };
}
