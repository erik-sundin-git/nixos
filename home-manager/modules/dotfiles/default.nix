{config, ...}: {
  home.file."${config.home.homeDirectory}/.config/qtile/" = {
    source = ./qtile;
    recursive = true;
  };
}
