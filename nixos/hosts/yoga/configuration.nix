{
  config,
  pkgs,
  inputs,
  nvim,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-12025783-11ce-4898-88c5-ecd4fd21f2c7".device = "/dev/disk/by-uuid/12025783-11ce-4898-88c5-ecd4fd21f2c7";
}
