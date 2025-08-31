{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    lutris
    protontricks
  ];
}
