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
          menuentry "Windows 10" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 2017-287E
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };
  };

  networking = {
    hostName = "amd";
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
