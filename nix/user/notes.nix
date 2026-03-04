{pkgs, ...}: {
  home.packages = with pkgs; [
    typora
    drawio
  ];
}
