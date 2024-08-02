# zsh.nix
# zsh config
{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    antidote
  ];

  programs.zsh = {
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    ### Plugins ###
    antidote.enable = true;
    antidote.plugins = [
      "zsh-users/zsh-syntax-highlighting"
      "zsh-users/zsh-autosuggestions"
      "zsh-users/zsh-history-substring-search"
    ];

    initExtra = "
    PROMPT='%~%# '\n
    eval '$(zoxide init zsh)'
    ";

    ## shell aliases ##
    shellAliases = {
      ".." = "cd ..";

      ## Git ##
      "gs" = "git status";
      "ga" = "git add *";
      "commit" = "git commit";
      "gp" = "git push";

      ## System ##
      "rebuild-config" = "sudo nixos-rebuild switch --impure --flake ${config.home.homeDirectory}/nix#erik";
      "update-config" = "${config.home.homeDirectory}/nix/modules/system/scripts/update.sh";
    };
  };
}
