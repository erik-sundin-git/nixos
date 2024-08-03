{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/default.nix
  ];

  home.username = "erik";
  home.homeDirectory = "/home/erik";
  home.stateVersion = "24.05"; # Don't change.

  home.packages = with pkgs; [
  ];

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
