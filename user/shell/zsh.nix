{pkgs, ...}: let
  # My shell aliases
  myAliases = {
    e = "exit";
    nvim = "nix develop ~/Documents/code/.dotfiles --command neovide -- -u ~/Documents/code/.dotfiles/init.lua";
    mdbook-open = "nix develop ~/Documents/code/.dotfiles --command mdbook serve --open";
  };
in {
  programs.zsh = {
    enable = true;
    autosuggestion.strategy = ["completion"];
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}
