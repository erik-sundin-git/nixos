{
  config,
  pkgs,
  inputs,
  nvim,
  ...
}: let
  homeDir = builtins.getEnv "HOME";
in {
  imports = [
  ];
  nix.settings.experimental-features = ["nix-command flakes"];
  networking.hostName = "nixos";
  #  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

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

  # Configure keymap in X11
  services.xserver = {
    layout = "se";
    xkbVariant = "";
  };

  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.root.ignoreShellProgramCheck = true;
  users.users.erik.ignoreShellProgramCheck = true;
  users.users.erik = {
    isNormalUser = true;
    description = "erik";
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.firefox.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    inputs.neovim.defaultPackage.x86_64-linux
  ];

  system.stateVersion = "24.05";
}
