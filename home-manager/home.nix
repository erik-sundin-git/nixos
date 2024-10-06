{
  config,
  pkgs,
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
  imports = [./modules];
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  rofi.enable = true;
  hyprland.enable = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.packages = [
    inputs.neovim.defaultPackage.x86_64-linux
    pkgs.wlroots
    pkgs.sct
    pkgs.tor-browser-bundle-bin
    pkgs.weylus
    pkgs.nixfmt-rfc-style
    pkgs.firefox

    pkgs.alacritty
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



  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  polybar.enable = true;
  #rofi.enable = true;
}
