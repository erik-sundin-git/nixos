{
  pkgs,
  lib,
  ...
}: {
  programs.chromium = {
    package = pkgs.brave;
    extensions = [
      {
        # Vimium
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
      }
      {
        # Bitwarden
        id = "nngceckbapebfimnlniiiahkandclblb";
      }
      {
        # DarkReader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      }
      {
        # Tokyo Night Theme
        id = "enpfonmmpgoinjpglildebkaphbhndek";
      }
    ];
  };
}
