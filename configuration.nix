{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./nixos
  ];

  boot = {
    kernelParams = [ "quiet" "splash" ];
    tmp = {
      cleanOnBoot = true;
      };
  };

  networking = {
    networkmanager = {
      enable = true;
    };
    # proxy = {}
      # default = "http://user:password@proxy:port/";
      # noProxy = "127.0.0.1,localhost,internal.domain";
    # };
    # wireless = {
      # enable = true;
    # };
  };

  time = {
    hardwareClockInLocalTime = true;
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
    };
  };

  hardware = {
    enableAllFirmware = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "electron-19.1.9" ];
    };
  };


  environment = {
    systemPackages = with pkgs; [
      btop
      cbonsai
      cmatrix
      fastfetch
      inputs.wfetch.packages.${pkgs.system}.default
      librewolf
      lsd
      neofetch
      (pkgs.nitch.overrideAttrs (o: {patches = (o.patches or []) ++ [./patches/nitch-nix-pkgs-count.patch];})) # fix nix package count for nitch
      ripgrep
      sops
      wallust
      webcord
      wget
    ];
  };

  users = {
    mutableUsers = false;
    users = {
      root = {
	  initialPassword = "password";
	  hashedPasswordFile = config.sops.secrets.rp.path;
	};
      jwrhine = {
        isNormalUser = true;
	description = "John";
	initialPassword = "password";
	hashedPasswordFile = config.sops.secrets.up.path;
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
