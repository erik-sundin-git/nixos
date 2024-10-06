{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  modules.qtile.enable = true;
#  services.desktopManager.plasma6.enable = true;

  system.bluetooth.enable = true;
  stylix.enable = true;
  hyprlandNixosModule.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-8b9e6618-2baf-46fe-809b-c4cbbb002d9f".device = "/dev/disk/by-uuid/8b9e6618-2baf-46fe-809b-c4cbbb002d9f";
  networking.hostName = "t14"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
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

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
    enable = true;
    videoDrivers = [ "modesetting" ];
    xkb.options = "ctrl:swapcaps";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  system.audio = {
    enable = true;
    desktop = true;
  };
  services.davfs2.enable = true;
  
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  services.libinput.enable = true;

  users.users.erik = {
    isNormalUser = true;
    description = "Erik Sundin";
    extraGroups = [
      "networkmanager"
      "wheel"
      "davfs2"
    ];
  };

  services.openssh = {
    enable = true;

  };
  security.polkit.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    brightnessctl
  ];

  environment.interactiveShellInit = ''
    alias rebuild="sudo nixos-rebuild switch --flake ~/nixos#thinkpad --impure"                                  
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  system.stateVersion = "24.05"; # Did you read the comment?
}
