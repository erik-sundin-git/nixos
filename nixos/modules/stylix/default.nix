# stylix configuration.
# The module is enabled on a per config basis
# in respective services.nix file.
{
  stylix,
  systemSettings,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [pkgs.base16-schemes];
  #stylix.image = config.lib.stylix.pixel "base0A";
  stylix.image = systemSettings.wallpaper;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
}
