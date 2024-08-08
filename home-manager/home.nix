{
  pkgs,
  config,
  ...
}: let
  homeDir = "/home/erik";
in {
  imports = [
    ./modules/default.nix
  ];

  home.username = "erik";
  home.homeDirectory = homeDir;
  home.stateVersion = "24.05"; # Don't change.

  home.packages = with pkgs; [
    pavucontrol
    nautilus
  ];

  home.sessionPath = [
    "${homeDir}/.config/emacs/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
