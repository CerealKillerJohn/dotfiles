{ config, pkgs, lib, ... }:

{
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
#        nitch
        wfetch --challenge --challenge-type GNOME --challenge-years 0 --challenge-months 6 --challenge-timestamp 1701208432 --wallpaper
        cat ~/.cache/wallust/sequences
      '';
    };
  };
}
