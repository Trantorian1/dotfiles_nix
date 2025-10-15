{pkgs, ...}: let
  # Setup home manager
  # https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";

  sources = import ../npins;
in {
  imports = [
    (import "${home-manager}/nixos")
    ./gnome.nix
    ./amd.nix
    ./audio.nix
  ];

  # Set home-manager to use the global nixpkgs
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "save";

  #  Setting up user with home-manager
  programs.fish.enable = true;
  users.users.trantorian = {
    isNormalUser = true;
    description = "trantorian";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
  };

  home-manager.users.trantorian = {pkgs, ...}: {
    imports = [
      (sources.catppuccin + "/modules/home-manager")
      ./user/git.nix
      ./user/fish.nix
      ./user/lsd.nix
      ./user/bat.nix
      ./user/obs.nix
      ./user/ssh.nix
      ./user/ghostty.nix
      ./user/librewolf.nix
      ./user/brave.nix
      ./user/steam.nix
      ./user/minecraft.nix
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.05";
  };
}
