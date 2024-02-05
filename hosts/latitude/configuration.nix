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
#    plymouth = {
#      enable = true;
#      theme = "breeze";
#    };
  };

  networking = {
    hostName = "latitude";
  };

  services = {
    xserver = {
      displayManager = {
        autoLogin = {
	  user = "jwrhine";
        };
      };
    };
    getty = {
      autologinUser = "jwrhine";
    };
  };

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
