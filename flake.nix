{
  description = "My Nix Configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-patched.url = "github:erik-sundin-git/nixpkgs?ref=picom-ftlabs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dots = {
      url = "github:erik-sundin-git/dotfiles";
      flake = false;
    };

    rofi-themes = {
      url = "github:lr-tech/rofi-themes-collection";
      flake = false;
    };

    qtile-flake = {
      url = "github:qtile/qtile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim.url = "github:erik-sundin-git/neovim";
    stylix.url = "github:danth/stylix";
    install-script.url = "path:./install";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-patched,
      install-script,
      neovim,
      stylix,
      home-manager,
      ...
    }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux"; # system arch
        homeDir = "/home/erik";
        user = "erik";
        wallpaper = ./home-manager/wallpapers/tokyo_night.jpg;
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config.allowUnfree = true;
      };

      pkgs-patched = import nixpkgs-patched {
        system = systemSettings.system;
        config.allowUnfree = true;
      };

      # * Variables to be used within the configurations
      args = {
        inherit inputs;
        inherit systemSettings;
        inherit pkgs-unstable;
        inherit pkgs-patched;
        inherit install-script;
      };
    in
    {
     homeConfigurations."erik" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./nixos/hosts/debian/home.nix ];
	extraSpecialArgs = args;
      };

      nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = args;
        modules = [
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.${systemSettings.user} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
          ./nixos/config.nix
          ./nixos/hosts/yoga/default.nix
          ./nixos/modules/default.nix
        ];
      };
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = args;
          modules = [
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.${systemSettings.user} = import ./home-manager/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
            ./nixos/hosts/desktop/default.nix
            ./nixos/modules
            ./nixos/config.nix
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = args;
          modules = [
            ./nixos/hosts/vm/default.nix
          ];
        };

        iso = nixpkgs.lib.nixosSystem {
          specialArgs = args;
          modules = [
            stylix.nixosModules.stylix
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            ./nixos/hosts/iso/configuration.nix
          ];
        };
      };

      packages.${systemSettings.system} = {
        install = install-script.packages.${systemSettings.system}.install; # basically just clones the repo atm.
      };
    };
}
