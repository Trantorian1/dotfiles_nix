{...}: {
  #  Setting up ssh authentication
  programs.ssh = {
    enable = true;
    matchBlocks = {
      github = {
        hostname = "github.com";
        identityFile = "~/.ssh/github";
      };
    };
  };
}
