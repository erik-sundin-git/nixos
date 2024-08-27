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
        script = "echo hello";
      in {
        packages = rec {
          install = pkgs.writeShellScriptBin "hello" ''${script}'';
          default = install;
        };
        apps = rec {
          install = flake-utils.lib.mkApp {drv = self.packages.${system}.install;};
          default = install;
        };
      }
    );
}
