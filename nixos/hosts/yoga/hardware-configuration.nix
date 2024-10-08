# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  systemSettings,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3ef12626-1af1-43e3-bd51-f976dd30d363";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-194cb90b-8127-47a3-aa3b-8e786b231d1a".device = "/dev/disk/by-uuid/194cb90b-8127-47a3-aa3b-8e786b231d1a";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C638-5C83";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/mnt/storagebox" = {
    device = "https://u416901.your-storagebox.de/";
    fsType = "davfs";
    options = ["user" "noauto"]; # Add additional options as needed
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/69a43c84-5fe9-447a-94aa-296b246e8b8a";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
