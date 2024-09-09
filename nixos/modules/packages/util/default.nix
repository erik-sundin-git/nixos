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
    packages.utils.enable = mkOption {
      type = types.bool;
      default = false;
      description = "";
    };
  };

  config = mkIf config.packages.utils.enable {

    environment.systemPackages = with pkgs; [
      sct
      htop
    ];
  };
}
