{
  inputs,
  pkgs,
  lib,
  systemSettings,
  ...
}:
let
  emacs-package = pkgs.emacsWithPackagesFromUsePackage {
    #package = pkgs.emacs-git;
    package = pkgs.emacs;
    config = ./config.org;
    defaultInitFile = true;

    alwaysEnsure = true;
    alwaysTangle = true;

    extraEmacsPackages = epkgs: [
      epkgs.magit
      epkgs.doom-themes
      epkgs.org-roam
    ];
  };
in
{
  services.emacs = {
    enable = true;
    package = emacs-package;
  };

  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }
    ))
  ];
}
