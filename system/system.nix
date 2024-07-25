{ config, pkgs, ... }:

{
  imports = [
    ./hardware/boot.nix
    ./hardware/kernel.nix
    ./hardware/rotation.nix
    ./hardware/sound.nix
    ./hardware/webcam.nix
    ./hardware/xbox.nix

    ./wm/gnome.nix
  ];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     xournalpp
     gnome.gnome-boxes
  ]) ++ (with pkgs.gnomeExtensions; [
     appindicator
  ]);
}
