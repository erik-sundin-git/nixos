# virt module
# Contains all system.bluetoothualization specific options.
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
    system.bluetooth.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable or disable the system.bluetooth-module.";
    };
  };

  config = mkIf config.system.bluetooth.enable {
    ### bluetooth ###
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    environment.systemPackages = [ ];
  };
}
