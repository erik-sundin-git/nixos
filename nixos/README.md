
# Table of Contents
  
1.  [Inputs](#org8394c02)
2.  [Configuration options](#org4c081b0)
3.  [Main config](#orga1e2156)
    1.  [Imports](#orgf7699fd)
    2.  [Networking](#orgc29b7f5)
    3.  [User](#orgc017204)
        1.  [Shell](#org64695bc)
    4.  [Nix Settings](#org9cadb4f)
    5.  [Locale](#orgd236c91)
    6.  [Audio](#org3ca25e0)
    7.  [X server](#org0f34ca5)
    8.  [Programs](#org60e0a5e)
    9.  [Packages](#orga053185)
    10. [Other](#org9cd8e37)
    11. [services](#org15507dd)
        1.  [Enable](#org434bcba)
        2.  [Flatpak](#org2998c27)
        3.  [davfs2](#org3803337)
4.  [KEEP LAST](#org925bd4a)



<a id="org8394c02"></a>

# Inputs

    {
      config,
      pkgs,
      inputs,
      nvim,
      ...
    }:


<a id="org4c081b0"></a>

# Configuration options

Variables and different files i use within my config.
These are the main options i change.

     let
      accessTokenFile = builtins.readFile /etc/githubtoken; # Isn't really using.
    
      userSettings = {
        username ="erik";
      };
    
      systemSettings = {
        networking.hostname = "yoga";
        packageSets = with packageSets; [desktop];
      };
    
      # From the unstable channel of nixpkgs
      defaultPackages = with pkgs; [
        git
        emacs
        inputs.neovim.defaultPackage.x86_64-linux
    
        # fonts
        fira
        fira-code
    
        # latex
        texliveFull
      ];
    
      # The different sets of packages.
      packageSets = {
        server = [];
        desktop = [pkgs.hello];
      };
    
      lib = pkgs.lib;
    
    in


<a id="orga1e2156"></a>

# Main config


<a id="orgf7699fd"></a>

## Imports

    {
    imports = [
    ];


<a id="orgc29b7f5"></a>

## Networking

    networking.hostName = systemSettings.networking.hostname;
    #  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;


<a id="orgc017204"></a>

## User

    users.users.${userSettings.username} = {
        isNormalUser = true;
        description = "";
        extraGroups = ["networkmanager" "wheel"];
        ignoreShellProgramCheck = true;
      };


<a id="org64695bc"></a>

### Shell

    users.defaultUserShell = pkgs.zsh;
    users.users.root.ignoreShellProgramCheck = true;


<a id="org9cadb4f"></a>

## Nix Settings

    nix.settings.experimental-features = ["nix-command flakes"];
    nix.extraOptions = "access-tokens = " + accessTokenFile;


<a id="orgd236c91"></a>

## Locale

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


<a id="org3ca25e0"></a>

## Audio

    # Enable sound with pipewire.
     hardware.pulseaudio.enable = false;
       services.pipewire = {
       enable = true;
       alsa.enable = true;
       alsa.support32Bit = true;
       pulse.enable = true;
       jack.enable = true;
     };


<a id="org0f34ca5"></a>

## X server

    services.xserver = {
      xkb.layout = "se";
      xkb.variant = "";
      libinput.enable = true;
      enable = true;
      videoDrivers = ["displaylink" "modesetting"];
    };


<a id="org60e0a5e"></a>

## Programs

    programs.firefox.enable = true;


<a id="orga053185"></a>

## Packages

    nixpkgs.config.allowUnfree = true;
    
    environment.systemPackages = lib.concatLists [
      [ (pkgs.writeShellScriptBin "nix-doom-install" (builtins.readFile ./scripts/nix-doom-install.sh)) ]
      systemSettings.packageSets
    ] ++ defaultPackages;


<a id="org9cd8e37"></a>

## TODO Other

    console.keyMap = "sv-latin1";
    
    # Enable CUPS to print documents.
    services.printing.enable = true;
    security.rtkit.enable = true;


<a id="org15507dd"></a>

## services

Enable services here. Their respective
Service can be seen below.


<a id="org434bcba"></a>

### Enable

    services.displayManager.sddm.enable = true;
    services.xserver.windowManager.qtile.enable = true;
    #services.desktopManager.plasma6.enable = true;
    services = {
      flatpak.enable = true;
      davfs2.enable = true;
    };


<a id="org2998c27"></a>

### Flatpak

      xdg.portal = lib.mkIf (config.services.flatpak.enable) {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };


<a id="org3803337"></a>

### davfs2

    services.autofs = lib.mkIf (config.services.davfs2.enable) {
      enable = false;
      debug = true;
      autoMaster = "
        /mnt/storagebox /etc/auto.dav
      ";
    };


<a id="org925bd4a"></a>

# KEEP LAST

      system.stateVersion = "24.05";
    }

