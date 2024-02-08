{ config, pkgs, lib, ... }:

{
  services = {
    xserver = {
      displayManager = {
        lightdm = {
          enable = true;
        };
      };
      desktopManager = {
        xfce = {
          enable = true;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      xfce.xfce4-pulseaudio-plugin
    ];
  };
}
