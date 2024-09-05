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
    pkgs.spice
    pkgs.zsh
    pkgs.nitrogen
    pkgs.ungoogled-chromium
    pkgs.qutebrowser
    pkgs.quickemu
    pkgs-patched.picom-ftlabs
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-03520681-0862-4dc1-b1f3-19a78e9b2e69".device = "/dev/disk/by-uuid/03520681-0862-4dc1-b1f3-19a78e9b2e69";

  stylix.enable = true;
}
