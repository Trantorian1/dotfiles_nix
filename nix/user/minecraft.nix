{pkgs, ...}: {
  home.packages = with pkgs; [
    modrinth-app
    xorg.libXtst
    xorg.libXext
    xorg.libXrender
  ];
}
