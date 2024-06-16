{ config, pkgs, option, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.trantorian = {
    isNormalUser = true;
    description = "trantorian";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "libvirtd" ];
    packages = with pkgs; [
      freetube
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
