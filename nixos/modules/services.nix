{
  config,
  lib,
  pkgs,
  ...
}: {
  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
}
