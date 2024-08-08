{config, ...}: {
  home.file."${config.home.homeDirectory}/.config/qtile/" = {
    source = ./qtile;
    recursive = true;
  };

  home.file."${config.home.homeDirectory}/.config/doom" = {
    source = ./doom;
    recursive = true;
  };
}
