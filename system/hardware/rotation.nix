{ config, pkgs, ... }:

{

  # Orientation and ambient light sensors
  hardware.sensor.iio.enable = true;

  environment.systemPackages = with pkgs.gnomeExtensions; [
     screen-rotate
  ];

}
