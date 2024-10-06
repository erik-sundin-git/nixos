{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
with lib; {
  options = {
    polybar.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable or disable the polybar-module.";
    };
  };

  config = mkIf config.polybar.enable {
    services.polybar = {
      enable = true;
      config = ./config.ini;
      script = "polybar example &";
    };
  };
}
