{ config, pkgs, lib, ... }:

{
  # booting with zfs
  boot = {
    supportedFilesystems = ["zfs"];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    zfs.requestEncryptionCredentials = true;
  };

  networking.hostId = "60cbcd2b"; # required for zfs

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  # 16GB swap
  swapDevices = [
    {device = "/dev/disk/by-label/SWAP";}
  ];

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

    # zfs datasets
    "/" = {
      device = "zroot/root";
      fsType = "zfs";
    };

    "/nix" = {
      device = "zroot/nix";
      fsType = "zfs";
    };

    "/tmp" = {
      device = "zroot/tmp";
      fsType = "zfs";
    };

    "/home" = {
      device = "zroot/home";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/persist" = {
      device = "zroot/persist";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/persist/cache" = {
      device = "zroot/cache";
      fsType = "zfs";
    };
  };
}
