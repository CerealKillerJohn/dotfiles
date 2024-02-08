{ config, pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      acpi
      arc-theme
      breeze-plymouth
      brightnessctl
#      (callPackage ../../packages/bar-protonmail/bar-protonmail.nix {})
      (callPackage ../../packages/boxbuddyrs/boxbuddyrs.nix {})
      distrobox
      fractal
      glib
      ifuse
      jq
      libimobiledevice
      libnotify
      lm_sensors
      mpv
      obs-studio
      parsec-bin
      pkgs.python311Full
      plymouth
      spotify
      spotifywm
      swappy
      usbmuxd
      wl-clipboard
      wlogout
      wlr-randr
      wofi
      zoom-us
      ];
  };
}
