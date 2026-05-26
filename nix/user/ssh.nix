{...}: {
  #  Setting up ssh authentication
  programs.ssh = {
    enable = true;
    matchBlocks = {
      github = {
        hostname = "ssh.github.com";
        identityFile = "~/.ssh/github";
        port = 443;
      };
    };
  };
}
