
# Table of Contents

1.  [My Nix Configuration](#org8847e6d)
    1.  [Flake Inputs](#org04f4268)
    2.  [Flake outputs](#org407c219)
    3.  [Flake settings](#org73e56f0)
    4.  [Nixos configurations](#org4d02502)
        1.  [Laptop](#org7aa125d)
        2.  [Desktop](#org3988dab)
        3.  [Virtual machine](#orgdff48da)
    5.  [Flake Packages](#org01f86c5)



<a id="org8847e6d"></a>

# My Nix Configuration

My Flake containing my different nixos systems and packages.
For Nixos config see [config](./nixos/config.md)


<a id="org04f4268"></a>

## Flake Inputs

    {
      description = "My Nix Configuration";
    
      inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
        nixpkgs-patched.url = "github:erik-sundin-git/nixpkgs?ref=picom-ftlabs";
    
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
        dots = {
          url = "github:erik-sundin-git/dotfiles/nix";
          flake = false;
        };
    
        neovim.url = "github:erik-sundin-git/neovim";
        stylix.url = "github:danth/stylix";
        install-script.url = "path:./install";
      };


<a id="org407c219"></a>

## Flake outputs

    outputs = {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-patched,
      install-script,
      neovim,
      stylix,
      home-manager,
      ...
    } @ inputs:


<a id="org73e56f0"></a>

## Flake settings

Some settings i use within my flake.

      let
      systemSettings = {
        system = "x86_64-linux"; # system arch
        homeDir = "/home/erik";
        user = "erik";
        wallpaper = ./wallpapers/misc/abstract/kanji-with-blobs_00_1920x1080.png;
      };
      
      pkgs-stable = import nixpkgs-stable {
        system = systemSettings.system;
        config.allowUnfree = true;
      };
    
      pkgs-patched = import nixpkgs-patched {
        system = systemSettings.system;
        config.allowUnfree = true;
      };
    
      /*
      * Variables to be used within the configurations
      */
      args = {
        inherit inputs;
        inherit systemSettings;
        inherit pkgs-stable;
        inherit pkgs-patched;
        inherit install-script;
      };
    in


<a id="org4d02502"></a>

## Nixos configurations


<a id="org7aa125d"></a>

### Laptop

    {
    nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
      system = systemSettings.system;
      specialArgs = args;
      modules = [
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${systemSettings.user} = import ./home-manager/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
        ./nixos/config.nix
        ./nixos/hosts/yoga/default.nix
        ./nixos/modules/default.nix
      ];
    };


<a id="org3988dab"></a>

### Desktop

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = systemSettings.system;
      specialArgs = args;
      modules = [
        ./nixos/config.nix
        ./nixos/hosts/desktop/default.nix
        ./nixos/modules/default.nix
      ];
    };


<a id="orgdff48da"></a>

### Virtual machine

    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = systemSettings.system;
      specialArgs = args;
      modules = [
        ./nixos/hosts/vm/default.nix
      ];
    };


<a id="org01f86c5"></a>

## Flake Packages

        packages.${systemSettings.system} = {
          install = install-script.packages.${systemSettings.system}.install; #basically just clones the repo atm.
        };
      };
    }

