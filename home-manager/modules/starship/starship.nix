{
  pkgs,
  config,
  lib,
  ...
}: {
  home.file = {
  "${config.home.homeDirectory}/.config/starship.toml".source = ./starship.toml;
  };
  programs.starship = {
    package = pkgs.starship;
    enableZshIntegration = true;
  };
}
