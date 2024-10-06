{
  inputs,
  pkgs,
  config,
  systemSettings,
  ...
}:
{
  programs.git.enable = true;
  programs.git.userName = "Erik Sundin";
  programs.git.userEmail = "mail@eriksundin.com";
}
