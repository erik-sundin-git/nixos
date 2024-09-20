{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
let
  themePath = "${inputs.rofi-themes.outPath}/themes";
in
with lib;
{
  options = {
    rofi.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable or disable the system.bluetooth-module.";
    };
  };

  config = mkIf config.rofi.enable {

    programs.rofi = {
      enable = true;
    };
    home.packages = [ pkgs.rofi ];
  };
}
