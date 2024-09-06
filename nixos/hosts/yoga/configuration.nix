{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-patched,
  stylix,
  inputs,
  nvim,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  environment.systemPackages = [
    pkgs.kitty
    pkgs.rofi
    pkgs.zsh
    pkgs-unstable.quickemu
    pkgs.nitrogen
    pkgs.ungoogled-chromium
    pkgs.qutebrowser
    pkgs-patched.picom-ftlabs
  ];

  stylix.enable = true;

  ### bluetooth ###
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-12025783-11ce-4898-88c5-ecd4fd21f2c7".device = "/dev/disk/by-uuid/12025783-11ce-4898-88c5-ecd4fd21f2c7";
}
