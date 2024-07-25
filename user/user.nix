{ config, pkgs, ... }:

{
  imports = [
    ./app/web/chromium.nix
    ./app/web/brave.nix
    ./app/web/proton-vpn.nix

    ./app/edit/gimp.nix
    ./app/edit/inkscape.nix

    ./app/video/vlc.nix

    ./shell/zsh.nix
    ./shell/utils.nix
  ];
}
