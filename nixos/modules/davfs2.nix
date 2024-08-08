{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.services.davfs2.enable {
    services.autofs = {
      enable = false; #not active
    };
  };
}
