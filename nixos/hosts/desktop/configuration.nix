{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-patched,
  stylix,
  inputs,
  nvim,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];
  environment.systemPackages = [
    pkgs.kitty
    pkgs.rofi
    pkgs.spice
    pkgs.zsh
    pkgs.nitrogen
    pkgs.ungoogled-chromium
    pkgs.qutebrowser
    pkgs-unstable.quickemu
    pkgs-patched.picom-ftlabs
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-03520681-0862-4dc1-b1f3-19a78e9b2e69".device = "/dev/disk/by-uuid/03520681-0862-4dc1-b1f3-19a78e9b2e69";

  stylix.enable = true;

  system.audio = {
    enable = true;
    desktop = true;
    pulseaudio = true;
    pipewire = false;
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
    ports = [
      2222
    ];
  };

  #TODO move to module
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 2222 ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

}
