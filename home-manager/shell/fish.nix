{ config, pkgs, lib, ... }:

{
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
#        nitch
#        cat ~/.cache/wallust/sequences
      '';
    };
  };
}
