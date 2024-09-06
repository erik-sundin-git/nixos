{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.system.audio;
in {
  options = {
    system.audio.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable system audio";
    };

    system.audio.desktop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable some packages only for desktop";
    };
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = lib.mkForce false;
    security.rtkit.enable = true;
    services.pipewire = {
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
  };
}
