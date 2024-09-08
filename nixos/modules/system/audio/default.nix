{
  config,
  lib,
  pkgs,
  systemSettings,
  ...
}:
with lib;
let
  cfg = config.system.audio;
in
{
  options = {
    system.audio.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable system audio";
    };

    system.audio.pulseaudio = mkOption {
      type = types.bool;
      default = false;
      description = "Enable pulseaudio config";
    };

    system.audio.pipewire = mkOption {
      type = types.bool;
      default = true;
      description = "Enable pipewire config";
    };

    system.audio.desktop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable some packages only for desktop";
    };
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = if cfg.pulseaudio then true else false;
    security.rtkit.enable = true;
    services.pipewire = mkIf cfg.pipewire {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    environment.systemPackages = mkIf cfg.desktop [
      pkgs.pavucontrol
      pkgs.ncspot
      pkgs.spotify
      pkgs.pulseaudio
      pkgs.spicetify-cli
    ];

    users.extraUsers.${systemSettings.user}.extraGroups = [ "audio" ];
  };
}
