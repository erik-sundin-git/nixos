{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.emacs.enable = true;

  programs.emacs.package = pkgs.emacs-unstable;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  system.activationScripts.doomemacs = ''
    if [ ! -d "$HOME/.config/doom" ]; then
    git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/config/emacs
    $HOME/.config/emacs/bin/doom install
    fi
  '';
}
