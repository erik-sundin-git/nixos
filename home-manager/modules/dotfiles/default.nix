{ config, inputs, ... }:
{
  home.file."${config.home.homeDirectory}/.config/qtile/" = {
    source = "${inputs.dots}/.config/qtile/";
    recursive = true;
  };
  home.file."${config.home.homeDirectory}/.config/picom/picom.conf".source = ./picom.conf;

  home.file."${config.home.homeDirectory}/.config/doom/config.el" = {
    source = "${inputs.dots}/.config/doom/config.el";
  };
  home.file."${config.home.homeDirectory}/.config/doom/init.el" = {
    source = "${inputs.dots}/.config/doom/init.el";
  };
 home.file."${config.home.homeDirectory}/.config/doom/packages.el" = {
    source = "${inputs.dots}/.config/doom/packages.el";
  };

}
