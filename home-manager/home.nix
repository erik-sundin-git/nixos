{pkgs,config, inputs, ...}: let
  homeDir = "/home/erik";
in {
  imports = [
    ./modules/default.nix
  ];

  home.username = "erik";
  home.homeDirectory = homeDir;
  home.stateVersion = "24.05"; # Don't change.

  home.packages = [
    pkgs.pavucontrol
  ];

  home.sessionPath = [
    "${homeDir}/.config/emacs/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
