{ config, pkgs, lib, ... }:

{
  imports = [
    ./dunst.nix
    ./firefox.nix
    ./mako.nix
    ./shell
  ];

  xdg = {
    configFile = {
      "bspwm" = {
        source = ./bspwm;
        recursive = true;
      };
      "doom" = {
        source = ./doom;
        recursive = true;
      };
      "fastfetch" = {
        source = ./fastfetch;
        recursive = true;
      };
#      "hypr" = {
#        source = ./hypr;
#        recursive = true;
#      };
      "i3" = {
        source = ./i3;
        recursive = true;
      };
      "i3status" = {
        source = ./i3status;
        recursive = true;
      };
      "neofetch" = {
        source = ./neofetch;
        recursive = true;
      };
      "polybar" = {
        source = ./polybar;
        recursive = true;
      };
      "qtile" = {
        source = ./qtile;
        recursive = true;
      };
      "ranger" = {
        source = ./ranger;
        recursive = true;
      };
      "rofi" = {
        source = ./rofi;
        recursive = true;
      };
      "spotify" = {
        source = ./spotify;
        recursive = true;
      };
      "sxhkd" = {
        source = ./sxhkd;
        recursive = true;
      };
      "waybar" = {
        source = ./waybar;
        recursive = true;
      };
    };
  };

  home.stateVersion = "23.11";
}
