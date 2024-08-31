#
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
{
  options = {

    flatpak.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable or disable the virt-module.";
    };
  };

  config = mkIf config.flatpak.enable {
    services.flatpak.enable = true;
    xdg.portal = {
    enable = true;
    config.common.default = "*";

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  };
}
