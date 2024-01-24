{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./default.nix
    ];

  boot = {
    tmp = {
      cleanOnBoot = true;
      };
  };

  networking = {
    networkmanager = {
      enable = true;
    };  
    # wireless = {
      # enable = true;
    # };  
  };

  time = {
    timeZone = "America/New_York";
  };  

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      # remove xterm by default
      excludePackages = [pkgs.xterm];
      displayManager = {
        sessionCommands = ''
	  if command -v feh >/dev/null; then
	    feh --randomize --bg-fill ~/Pictures/Wallpapers/*
	  fi
        '';
      };	
    };  
  };

  hardware = {
    enableAllFirmware = true;
  };

  users = {
    users = {
      jwrhine = {
        isNormalUser = true;
	description = "John";
	extraGroups = [
	  "networkmanager"
	  "users"
	  "wheel"
	];
	packages = with pkgs; [];
      };
    };
  };  

  system = {
    # do not change this value
    stateVersion = "23.11";
  };
}
