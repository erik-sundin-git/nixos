{
  config,
  pkgs,
  inputs,
  nvim,
  ...
}:

 let
  accessTokenFile = builtins.readFile /etc/githubtoken; # Isn't really using.



  lib = pkgs.lib;
in

  {
  imports = [
  ];

  networking.hostName = "nixos";
  #  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

users.users.erik = {
    isNormalUser = true;
    description = "erik";
    extraGroups = ["networkmanager" "wheel"];
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.root.ignoreShellProgramCheck = true;
  users.users.erik.ignoreShellProgramCheck = true;

nix.settings.experimental-features = ["nix-command flakes"];
nix.extraOptions = "access-tokens = " + accessTokenFile;

  time.timeZone = "Europe/Stockholm";
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

 # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
    services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
    libinput.enable = true;
    enable = true;
    videoDrivers = ["displaylink" "modesetting"];
  };

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    inputs.neovim.defaultPackage.x86_64-linux
    git
    emacs

    fira
    fira-code
    (writeShellScriptBin "nix-doom-install" (builtins.readFile ./scripts/nix-doom-install.sh))
  ];

  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  security.rtkit.enable = true;

  services.displayManager.sddm.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  #services.desktopManager.plasma6.enable = true;
  services = {
    flatpak.enable = true;
    davfs2.enable = true;
  };

    xdg.portal = lib.mkIf (config.services.flatpak.enable) {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

    services.autofs = lib.mkIf (config.services.davfs2.enable) {
      enable = false;
      debug = true;
      autoMaster = "
        /mnt/storagebox /etc/auto.dav
      ";
    };

  system.stateVersion = "24.05";
}
