{ config, pkgs, lib, ... }:

{
  programs = {
    bash = {
      enable = true;
      initExtra = ''
#        nitch
        wfetch --challenge --challenge-timestamp 1676062449 --wallpaper
        cat ~/.cache/wallust/sequences
      '';
    };
  };
}
