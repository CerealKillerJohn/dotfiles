{ config, pkgs, lib, ... }:

{
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
#        nitch
        wfetch --challenge --challenge-timestamp 1676062449 --wallpaper --exit
        cat ~/.cache/wallust/sequences
      '';
    };
  };
}
