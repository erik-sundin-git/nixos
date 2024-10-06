{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio
    ./bluetooth
  ];
}
