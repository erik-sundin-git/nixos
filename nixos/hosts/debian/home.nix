{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let

in {
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    #inputs.qtile-flake.packages.x86_64-linux.qtile
    pkgs.qtile
    inputs.neovim.defaultPackage.x86_64-linux
    pkgs.wlroots
    pkgs.ncspot
    pkgs.sct
    pkgs.tor-browser-bundle-bin
    pkgs-unstable.picom
    pkgs.weylus
    pkgs-unstable.spotify
    pkgs.quickemu
    pkgs.nixfmt-rfc-style
    pkgs.firefox

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "set-brightness" "$HOME/dotfiles/scripts/set-brightness.sh")
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  #rofi.enable = true;
}
