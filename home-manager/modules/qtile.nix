{
  inputs,
  pkgs,
  lib,
  config,
  systemSettings,
  ...
}: {
  home.file.".config/qtile" = {
    enable = true;
    recursive = true;
    source = "${systemSettings.dotfilesPath}/qtile";
  };
}
