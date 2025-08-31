{...}: {
  # Install Bat and use it as the default pager
  programs.bat = {
    enable = true;
  };
  home.sessionVariables = {
    MANPAGER = "bat -l man -p";
  };
  catppuccin.bat = {
    enable = true;
    flavor = "macchiato";
  };
}
