{
  config,
  lib,
  pkgs,
  systemSettings,
  ...
}:

with lib;

let
  /* This script is placed in ~/.config/qtile
   * and is activated when qtile is started.
   */
  autostartScript = pkgs.writeShellScriptBin "qtile-autostart.sh" ''
    # set wallpaper
    ${pkgs.nitrogen}/bin/nitrogen --set-scaled ${systemSettings.wallpaper} 

    # start polybar
    systemctl --user start polybar.service

    # start picom
    picom --backend xrender --config /home/erik/.config/picom/picom.conf
  '';

  cfg = config.modules.qtile;

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ./brightness-up.sh;
  brightness-down = pkgs.writeShellScriptBin "brightness-down" ./brightness-down.sh;
  brightness-set = pkgs.writeShellScriptBin "brightness-set" ./brightness-set.sh;
in
{
  imports = [
    #    ./config.nix might move the actual config into a nix file.
  ];

  options = {
    modules.qtile.enable = mkEnableOption "Enable the Qtile window manager";
    modules.qtile.activationScript = mkOption { default = autostartScript.outPath; };

    modules.qtile.picomConfig = mkOption { default = ./picom.conf; };
    
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.qtile = {
      enable = true;
      configFile = ./config.py;
    };

    system.activationScripts = {
      qtile.text = ''
        if [ ! -d /home/erik/.config/qtile ]; then
          mkdir /home/erik/.config/qtile
        fi
        cp ${autostartScript.outPath}/bin/qtile-autostart.sh /home/erik/.config/qtile/
      '';

      picom.text = ''
        if [ ! -d /home/erik/.config/picom ]; then
          mkdir /home/erik/.config/picom
        fi
        cp ${cfg.picomConfig} /home/erik/.config/picom/picom.conf
      '';
    };

    environment.systemPackages = with pkgs; [
      polybar
      nitrogen
      picom
      gnome.nautilus
      brightness-up
      brightness-down
      brightness-set
    ];
  };
}
