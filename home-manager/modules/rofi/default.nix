{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  systemSettings,
  inputs,
  ...
}:
let
  themePath = "${inputs.rofi-themes.outPath}/setup.sh";
  rofi-cmd = pkgs.writeShellScriptBin "rofi-cmd" ''
        rofi -e "$(bash -c "$(rofi -dmenu -p 'Run command' -theme-str 'listview {lines: 0;}')" 2>&1 )"
      '';
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
    home.packages = [
      pkgs.rofi
      #(pkgs.writeShellScriptBin "install-rofi-themes" themePath)
      rofi-cmd

    ];
  };
}
