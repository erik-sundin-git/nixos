# stylix configuration.
# The module is enabled on a per config basis
# in respective services.nix file.
{
  stylix,
  systemSettings,
  pkgs,
  config,
  ...
}:
let
  brightness ="-30";
  contrast = "0";
  fillColor = "black";
in
{
  environment.systemPackages = [pkgs.base16-schemes];
  #stylix.image = config.lib.stylix.pixel "base0A";
  stylix.image = pkgs.runCommand "dimmed-background.png" { } ''
    ${pkgs.imagemagick}/bin/convert "${systemSettings.wallpaper}" -brightness-contrast ${brightness},${contrast} -fill ${fillColor} $out
  '';
  stylix.polarity = "dark";
#  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
}
