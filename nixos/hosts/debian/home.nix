{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    #inputs.qtile-flake.packages.x86_64-linux.qtile
    pkgs.qtile
    inputs.neovim.defaultPackage.x86_64-linux
    pkgs.coreutils-full
    pkgs.wlroots
    pkgs.ncspot
    pkgs.woeusb
    pkgs.weylus
  #  pkgs.spotify
    pkgs.quickemu
    pkgs.nixfmt-rfc-style
    pkgs.firefox
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  home.file."${config.home.homeDirectory}/.config/qtile/" = {
    source = "${inputs.dots}/.config/qtile/";
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
