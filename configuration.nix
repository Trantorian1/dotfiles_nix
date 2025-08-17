# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Setup home manager
  # https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;

  # Pin the version of nixpkgs being used
  sources = import ./npins;
  system = builtins.currentSystem;
  pkgs = import sources.nixpkgs {
    inherit system;
    config = {};
    overlays = [];
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Load home-manager
    (import "${home-manager}/nixos")
  ];

  # Set home-manager to use the global nixpkgs
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "save";
  # Change nixos configuration path
  nix.nixPath = [
    "nixos-config=/home/trantorian/Documents/code/dotfiles/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define your hostname.
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # AMD graphics card support
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #  Setting up user with home-manager
  programs.fish.enable = true;
  users.users.trantorian = {
    isNormalUser = true;
    description = "trantorian";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  home-manager.users.trantorian = {pkgs, ...}: {
    home.packages = with pkgs; [
      git
      steam
      lutris
      protontricks
    ];

    # Set fish as the default shell
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        # Disable the default greeting
        set fish_greeting

        # https://github.com/catppuccin/fish/blob/main/themes/Catppuccin%20Latte.theme
        set fish_color_normal 4c4f69
        set fish_color_command 1e66f5
        set fish_color_param dd7878
        set fish_color_keyword d20f39
        set fish_color_quote 40a02b
        set fish_color_redirection ea76cb
        set fish_color_end fe640b
        set fish_color_comment 8c8fa1
        set fish_color_error d20f39
        set fish_color_gray 9ca0b0
        set fish_color_selection --background=ccd0da
        set fish_color_search_match --background=ccd0da
        set fish_color_option 40a02b
        set fish_color_operator ea76cb
        set fish_color_escape e64553
        set fish_color_autosuggestion 9ca0b0
        set fish_color_cancel d20f39
        set fish_color_cwd df8e1d
        set fish_color_user 179299
        set fish_color_host 1e66f5
        set fish_color_host_remote 40a02b
        set fish_color_status d20f39
        set fish_pager_color_progress 9ca0b0
        set fish_pager_color_prefix ea76cb
        set fish_pager_color_completion 4c4f69
        set fish_pager_color_description 9ca0b0
      '';
    };
    home.shell.enableFishIntegration = true;

    # Install firefox.
    programs.firefox.enable = true;

    # Setting up git
    programs.git = {
      enable = true;
      userName = "trantorian";
      userEmail = "114066155+Trantorian1@users.noreply.github.com";
      extraConfig = {
        core = {
          pager = "";
        };
      };
    };

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

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.05";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
