{
  config,
  inputs,
  ...
}: {
  home.file."${config.home.homeDirectory}/.config/qtile/" = {
    source = "${inputs.dots}/.config/qtile/";
    recursive = true;
  };
  home.file."${config.home.homeDirectory}/.config/picom/picom.conf".source = ./picom.conf;

  home.file."${config.home.homeDirectory}/.config/doom" = {
    source = "${inputs.dots}/.config/doom";
    recursive = true;
  };
}
