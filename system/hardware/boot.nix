{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-2c95adfa-dcfc-49a6-868a-4520eb5f19bc".device = "/dev/disk/by-uuid/2c95adfa-dcfc-49a6-868a-4520eb5f19bc";

  # Fixes X server not starting with Intel Evo graphics
  boot.kernelParams = [ "i915.force_probe=7d55" ];

  # Fix tty1 boot
  services.displayManager.sddm.settings.General.DisplayServer = "x11-user";
}
