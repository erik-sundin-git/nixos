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
with lib; {
  options = {
    virt.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable or disable the virt-module.";
    };
  };

  config = mkIf config.virt.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };

    users.extraGroups.vboxusers.members = ["erik"];

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    security.polkit.enable = mkForce true;
    environment.systemPackages = [
      pkgs-unstable.spice
      pkgs-unstable.qemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";

          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
