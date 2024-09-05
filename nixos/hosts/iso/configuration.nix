{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  systemSettings,
  ...
}:

{
  imports = [ ../../modules ];

  nixpkgs.hostPlatform = systemSettings.system;

  environment.systemPackages = [
    inputs.neovim.defaultPackage.${systemSettings.system}
    pkgs.git
    pkgs.parted
  ];

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.qemuGuest.enable = true;
  services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
  # Configure keymap in X11
  services.xserver = {
    layout = "se";
    xkbVariant = "";
  };

  networking = {
    hostName = "iso";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Configure console keymap
  console.keyMap = "sv-latin1";

}
