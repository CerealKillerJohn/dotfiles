{ config, pkgs, lib, ... }:

{
  systemd = {
    services = {
      "getty@tty1".enable = false; # fixes autologin with gdm
      "autovt@tty1".enable = false; # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    };
  };

  services = {
    udev = {
      packages = with pkgs; [
        gnome.gnome-settings-daemon
        ];
      };
    xserver = {
      displayManager = {
        gdm = {
          enable = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.burn-my-windows
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-dock
      gnomeExtensions.media-controls
      gnomeExtensions.notification-timeout
      gnomeExtensions.only-window-maximize
      gnomeExtensions.tailscale-status
      gnome-extension-manager
      ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
#    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  home-manager.users.jwrhine = {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };
}
