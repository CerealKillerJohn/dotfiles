{ config, pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      firefox
      krita
      libsForQt5.kcalc
    ];
  };
}
