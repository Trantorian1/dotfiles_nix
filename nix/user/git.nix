{...}: {
  # Setting up git
  programs.git = {
    enable = true;
    userName = "trantorian";
    userEmail = "114066155+Trantorian1@users.noreply.github.com";
    extraConfig = {
      core = {
        pager = "";
        editor = "nvim";
      };
    };
  };
}
