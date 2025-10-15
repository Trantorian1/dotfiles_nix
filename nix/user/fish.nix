{...}: {
  # Set fish as the default shell
  programs.fish = {
    enable = true;
    shellAliases = {
      # nvim = "nix develop --extra-experimental-features nix-command --extra-experimental-features flakes --command 'nix-shell /home/trantorian/Documents/code/dotfiles/nvim --arg path $(pwd) --command \'neovide -- -u $CONFIG/init.lua && exit\'' 2>/dev/null || nix-shell --arg path $(pwd) --run 'nix-shell /home/trantorian/Documents/code/dotfiles/nvim --arg path $(pwd) --command \'neovide -- -u $CONFIG/init.lua && exit\'' 2>/dev/null || nix-shell /home/trantorian/Documents/code/dotfiles/nvim --arg path $(pwd) --command \'neovide -- -u $CONFIG/init.lua && exit\'";
      nvim = "nix-shell /home/trantorian/Documents/code/dotfiles/nvim --arg path $(pwd) --run 'neovide -- -u $CONFIG/init.lua && exit'";
      e = "exit";
      # ls = "lsd";
    };
    interactiveShellInit = ''
      # Disable the default greeting
      set fish_greeting
    '';
  };
}
