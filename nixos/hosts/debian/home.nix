{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-medium
      wrapfig
      dvipng
      capt-of
      ;
  };
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
    pkgs.weylus
    pkgs.nixfmt-rfc-style
    pkgs.firefox


    pkgs-unstable.picom
    pkgs-unstable.spotify
    pkgs-unstable.spot
    pkgs-unstable.librespot
    pkgs.musescore

    tex
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "ext-screen-init" "$HOME/dotfiles/scripts/ext-screen-init.sh")
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  polybar.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  #rofi.enable = true;
}
