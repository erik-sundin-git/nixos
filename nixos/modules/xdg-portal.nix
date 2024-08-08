{
  pkgs,
  lib,
  config,
  ...
}: let
  flatpakEnabled = builtins.getAttr "enable" config.services.flatpak or false;
in {
  config = lib.mkIf flatpakEnabled {
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
