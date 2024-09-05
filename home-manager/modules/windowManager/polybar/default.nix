{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let

in
{
  options = {
    windowManager.polybar.enable = mkEnableOption "Polybar status bar";
  };

  config = mkIf config.windowManager.polybar.enable {
    services.polybar.enable = true;

    services.polybar.script = "polybar top &";

    services.polybar.settings = {
      "bar/top" = {
        monitor = "DP-3";
        modules-right = "volume";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        format.volume = " ";
        label.muted.text = "🔇";
        label.muted.foreground = "#666";
        ramp.volume = [
          "🔈"
          "🔉"
          "🔊"
        ];
        click.right = "pavucontrol &";
      };
    };
  };
}
