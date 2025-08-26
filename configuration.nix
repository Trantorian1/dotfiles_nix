# Edit this configuration file to define what should be installed onconfig
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

  # Remove default Gnome packages
  # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
  environment.gnome.excludePackages = with pkgs; [
    baobab # disk usage analyzer
    cheese # photo booth
    eog # image viewer
    epiphany # web browser
    gedit # text editor
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    file-roller # archive manager
    geary # email client
    seahorse # password manager
    snapshot # camera
    decibels # audio player

    # these should be self explanatory
    gnome-shell
    gnome-console
    gnome-tour
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    gnome-connections
    xterm
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

  # Enabling Docker
  virtualisation.docker = {
    enable = true;
  };

  #  Setting up user with home-manager
  programs.fish.enable = true;
  users.users.trantorian = {
    isNormalUser = true;
    description = "trantorian";
    extraGroups = ["networkmanager" "wheel" "docker"];
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
      shellAliases = {
        nvim = "CMD='nix-shell /home/trantorian/Documents/code/dotfiles/nvim --arg path $(pwd) --command \'neovide --frame none -- -u $CONFIG/init.lua && exit\'' nix develop --extra-experimental-features nix-command --extra-experimental-features flakes --command $CMD 2>/dev/null || nix-shell --arg path $(pwd) --run $CMD 2>/dev/null || fish -c $CMD 2>/dev/null";
        e = "exit";
        # ls = "lsd";
      };
      interactiveShellInit = ''
        # Disable the default greeting
        set fish_greeting
      '';
    };

    # Replace ls with lsd
    programs.lsd = {
      enable = true;
      enableFishIntegration = true;
      # https://github.com/catppuccin/lsd/blob/main/themes/catppuccin-latte/colors.yaml
      colors = {
        user = "#8839ef";
        group = "#7287fd";
        permission = {
          read = "#40a02b";
          write = "#df8e1d";
          exec = "#e64553";
          exec-sticky = "#8839ef";
          no-access = "#6c6f85";
          octal = "#179299";
          acl = "#179299";
          context = "#04a5e5";
        };
        date = {
          hour-old = "#179299";
          day-old = "#04a5e5";
          older = "#209fb5";
        };
        size = {
          none = "#6c6f85";
          small = "#40a02b";
          medium = "#df8e1d";
          large = "#fe640b";
        };
        inode = {
          valid = "#ea76cb";
          invalid = "#6c6f85";
        };
        links = {
          valid = "#ea76cb";
          invalid = "#6c6f85";
        };
        tree-edge = "#5c5f77";
        git-status = {
          default = "#4c4f69";
          unmodified = "#6c6f85";
          ignored = "#6c6f85";
          new-in-index = "#40a02b";
          new-in-workdir = "#40a02b";
          typechange = "#df8e1d";
          deleted = "#d20f39";
          renamed = "#40a02b";
          modified = "#df8e1d";
          conflicted = "#d20f39";
        };
      };
    };

    # Install Ghostty
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "dark:catppuccin-macchiato,light:catppuccin-latte";
        shell-integration = "fish";
        cursor-style = "bar";
        keybind = [
          # Navigate splits
          "alt+left=goto_split:left"
          "alt+right=goto_split:right"
          "alt+down=goto_split:down"
          "alt+up=goto_split:up"

          # New splits
          "alt+shift+left=new_split:left"
          "alt+shift+right=new_split:right"
          "alt+shift+down=new_split:down"
          "alt+shift+up=new_split:up"
        ];
      };
    };

    # Install Librewolf
    programs.librewolf = {
      enable = true;
      settings = {
        # Enabling google safe browsing
        # https://librewolf.net/docs/settings/#enable-google-safe-browsing
        "browser.safebrowsing.malware.enabled" = true;
        "browser.safebrowsing.phishing.enabled" = true;
        "browser.safebrowsing.blockedURIs.enabled" = true;
        "browser.safebrowsing.provider.google4.gethashURL" = "https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
        "browser.safebrowsing.provider.google4.updateURL" = "https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
        "browser.safebrowsing.provider.google.gethashURL" = "https://safebrowsing.google.com/safebrowsing/gethash?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2";
        "browser.safebrowsing.provider.google.updateURL" = "https://safebrowsing.google.com/safebrowsing/downloads?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%";
        "browser.safebrowsing.downloads.enabled" = true;

        # Do not restore tabs on crash
        # https://librewolf.net/docs/settings/#stop-librewolf-from-resuming-after-a-crash
        "browser.sessionstore.resume_from_crash" = false;

        # Stricter autoplay prevention
        # https://librewolf.net/docs/settings/#use-a-stricter-autoplay-policy
        "media.autoplay.blocking_policy" = 2;

        # Disable history
        "places.history.enabled" = false;

        # Homepage
        "browser.startup.homepage" = "https://discord.com/login|https://app.gather.town/signin|https://slack.com/signin#/signin|https://app.deel.com/login|https://app.rippling.com/sign-in/id|https://id.atlassian.com/login|https://claude.ai/login|https://account.proton.me/mail|https://account.proton.me/calendar|https://github.com/login|https://habitica.com/login|https://www.odoo.com/web/login|https://web.whatsapp.com/|https://web.telegram.org/|https://tidal.com/login/";

        # Use vertical tabs
        "sidebar.verticalTabs" = true;

        # Default extensions
        "browser.policies.runOncePerModification.extensionsInstall" = ''
          [
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
            "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi"
            "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi"
          ]
        '';
      };
    };

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
