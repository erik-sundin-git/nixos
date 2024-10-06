{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
with lib;
{
  options = {
    hyprland.enable = mkOption {
      type = types.bool;
      default = false;
      description = "My Hyprland Config";
    };
  };

  config = mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {

     enable = true;
     settings = {
       bindm = [
         "SUPER, d ,exec rofi -show drun"
       ];
     };
    };
    programs.kitty.enable = true;
    home.packages = [ ];
  };
}
