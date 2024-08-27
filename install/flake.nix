{
  description = "Flake utils demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        script = "
        mkdir $out
        cd out
        ${pkgs.git}/bin/git clone https://github.com/erik-sundin-git/nixos.git
        cd nixos
        ";
      in {
        packages = rec {
          install = pkgs.writeShellScriptBin "install-config" ''${script}'';
          default = install;
        };
        apps = rec {
          install = flake-utils.lib.mkApp {drv = self.packages.${system}.install;};
          default = install;
        };
      }
    );
}
