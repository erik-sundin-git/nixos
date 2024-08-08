{config, ...}: {
  home.file."${config.home.homeDirectory}/.config/qtile/" = {
    source = ./qtile;
    recursive = true;
  };
  home.file."${config.home.homeDirectory}/.config/picom/picom.conf".source = ./picom.conf;

  home.file."${config.home.homeDirectory}/.config/doom" = {
    source = ./doom;
    recursive = true;
  };
}
