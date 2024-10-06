# Install Doom emacs
#
${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
rm -rf ~/.emacs.d
