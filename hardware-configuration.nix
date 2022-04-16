{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix") ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedisstributableFirmware;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  boot.initrd.luks.devices."nixos-decrypted".device = "/dev/disk/by-partlabel/root";
  # try later also "sr_mod"
  boot.initrd.availableKernelModules =
    [ "ahci"
      "nvme"
      "sd_mod"
      "xhci_pci"
      "virtio_pci"
      "virtio_blk"
    ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
}
