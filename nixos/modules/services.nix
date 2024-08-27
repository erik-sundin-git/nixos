{
  config,
  systemSettings,
  lib,
  pkgs,
  ...
}: {
  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  #services.desktopManager.plasma6.enable = true;
  services.davfs2.enable = true;
  services.flatpak.enable = true;
}
