{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./default.nix
    ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 9E0A-C145
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };
  };

  networking = {
    hostName = "amd";
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
