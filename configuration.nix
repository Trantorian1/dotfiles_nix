# Edit this configuration file to define what should be installed onconfig
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{config, ...}: let
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
    ./nix/home_manager.nix
  ];

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

  # Extra kernel modules
  boot.extraModulePackages = with config.boot.kernelPackages; [
    perf
    v4l2loopback
  ];

  # Enabling virtual camera for obs
  boot.extraModprobeConfig = ''options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1'';
  security.polkit.enable = true;

  # so perf can find kernel modules
  # https://github.com/TUM-DSE/doctor-cluster-config/blob/fbc549f574c4d3b0031e94996814e135fe04822a/modules/tracing.nix#L7
  systemd.tmpfiles.rules = [
    "L /lib - - - - /run/current/system/lib"
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enabling Docker
  virtualisation.docker = {
    enable = true;
  };

  # Enabling nix-ld to run dynamically linked executables (this is useful for dev purposes)
  # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    elfutils
  ];

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
