{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./default.nix
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    initrd = {
      systemd = {
        enable = true;
      };
    };
    kernelParams = ["quiet"];
    plymouth = {
      enable = true;
      theme = "breeze";
    };
  };

  networking = {
    hostName = "latitude";
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "jwrhine";
      };
      default_session = initial_session;
    };
  };

#  services = {
#    xserver = {
#      displayManager = {
#        autoLogin = {
#	  user = "jwrhine";
#        };
#      };
#    };
#    getty = {
#      autologinUser = "jwrhine";
#    };
#  };

  hardware = {
    bluetooth = {
      enable = true;
    };
  };

  custom = {
    impermanence = {
      enable = true;
    };
  };
}
