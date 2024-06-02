{ config, pkgs, ... }:

{

  # Configure Gnome desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Excluding some default Gnome applications
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese		# webcam
    epiphany		# web browser
    geary		# email reader
    evince		# document reader
    totem		# video player
    tali		# poker game
    iagno		# go game
    hitori		# sudoku game
    atomix		# puzzle game
    eog			# image viewer
    yelp		# help viewer
    file-roller		# archive manager
    seahorse		# password manager

    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
    gnome-system-monitor gnome-weather gnome-disk-utility
  ]);

  # Systray icons
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

}
