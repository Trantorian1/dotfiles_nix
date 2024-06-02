{ config, pkgs, ... }:

{

  # Webcam support
  # boot.kernelModules = [ "uvcvideo" ];

  # TODO: enabling this with latest kernel module results in failed build,
  # find a way to fix this.
  # hardware.ipu6 = {
    # enable = true;
    # platform = "ipu6";
  # };

}
