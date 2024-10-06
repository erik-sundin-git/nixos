{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
with lib;
{
  options = {
    hyprlandNixosModule.enable = mkOption {
      type = types.bool;
      default = false;
      description = "My Hyprland config.";
    };
  };

  config = mkIf config.hyprlandNixosModule.enable {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
    
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.systemPackages = [ ];
  };
}
