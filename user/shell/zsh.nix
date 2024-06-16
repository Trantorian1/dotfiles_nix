{ pkgs, ... }:
let
  # My shell aliases
  myAliases = {
    e = "exit";
    nvim = "nix develop ~/Documents/code/rust/.dotfiles --command neovide -- -u ~/Documents/code/rust/.dotfiles/init.lua";
  };
in
{

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

}
