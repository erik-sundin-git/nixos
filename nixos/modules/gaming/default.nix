# virt module
# Contains all virtualization specific options.
#
#
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
    gaming.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable or disable the gaming-module.";
    };
  };

  config = mkIf config.gaming.enable {
    programs.steam.enable = true;
    programs.gamescope.enable = true;
    environment.systemPackages = if config.virt.enable then [ ] else [ pkgs.discord ];

    systemd.user.services.discord = mkIf config.gaming.enable {
      description = "Discord Flatpak";
      serviceConfig.ExecStart = "${pkgs.flatpak}/bin/flatpak install flathub com.discordapp.Discord -y";
      wantedBy = [ "default.target" ];
    };
  };
}
