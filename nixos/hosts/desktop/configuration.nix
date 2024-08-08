{
  config,
  pkgs,
  pkgs-stable,
  pkgs-patched,
  inputs,
  nvim,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  programs.steam.enable = true;
  services.flatpak.enable = true;

  environment.systemPackages = [
    pkgs.kitty
    pkgs.rofi
    pkgs.zsh
    pkgs.nitrogen
    pkgs.ungoogled-chromium
    pkgs.unzip
    pkgs-stable.qutebrowser
    pkgs-patched.picom-ftlabs
    pkgs.wineWowPackages.staging

    pkgs.ardour
    pkgs.yabridge
    pkgs.yabridgectl
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.opengl.enable = true;
}
