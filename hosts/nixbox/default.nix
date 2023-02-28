
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vagrant.nix
      ./custom-configuration.nix
    ];

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;

  # Use the GRUB 2 EFI boot loader.
  boot.loader.systemd-boot = {
    enable = false;
    editor = false;
  };
  boot.loader.efi = {
    canTouchEfiVariables = false;
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    fsIdentifier = "label";
    splashMode = "stretch";
    version = 2;
    device = "nodev";
    extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
  };
}