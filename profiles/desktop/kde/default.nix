{ config, pkgs, lib, ... }: {
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbModel = "us";
    xkbOptions = "grp:alt_shift_toggle";
  };

  # Enable the KDE Plasma system.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # X11
  # services.xserver.enable = true;
}