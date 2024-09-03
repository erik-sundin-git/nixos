{
  config,
  pkgs,
  inputs,
  nvim,
  ...
}:

 let
  accessTokenFile = builtins.readFile /etc/githubtoken; # Isn't really using.

  userSettings = {
    username ="erik";
  };

  systemSettings = {
    networking.hostname = lib.mkDefault "yoga";
  };

  # From the unstable channel of nixpkgs
  defaultPackages = with pkgs; [
    git
    emacs
    inputs.neovim.defaultPackage.x86_64-linux
    pkgs.nixfmt-rfc-style
    # fonts
    fira
    fira-code

    # latex
    texliveFull

    ledger
  ];

  lib = pkgs.lib;

in

  {
  imports = [
  ./modules
  ];
  virt.enable = true;
  system.audio.enable = true;
  system.audio.desktop = true;

  networking.hostName = systemSettings.networking.hostname;
  #  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "";
    extraGroups = ["networkmanager" "wheel"];
    ignoreShellProgramCheck = true;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.root.ignoreShellProgramCheck = true;

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

  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
    enable = true;
    videoDrivers = ["displaylink" "modesetting"];
  };
  services.libinput.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = lib.concatLists [
    [ (pkgs.writeShellScriptBin "nix-doom-install" (builtins.readFile ./scripts/nix-doom-install.sh)) ]
  ] ++ defaultPackages;

  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  security.rtkit.enable = true;

  services.displayManager.sddm.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services = {
    davfs2.enable = true;
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
