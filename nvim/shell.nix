{path}: let
  rustOverlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");

  sources = import ../npins;
  system = builtins.currentSystem;
  pkgs = import sources.nixpkgs {
    inherit system;
    config = {};
    overlays = [rustOverlay];
  };

  rustVersion = "1.89.0";
  rust = pkgs.rust-bin.stable.${rustVersion}.default.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
    ];
    targets = [
      "wasm32-unknown-unknown"
    ];
  };
in
  pkgs.mkShell rec {
    packages = with pkgs; [
      busybox
      cacert
      pkg-config
      openssl
      xclip
      git
      fish
      htop
      ripgrep

      gnumake
      rust
      mdbook
      mdbook-mermaid

      lua-language-server
      stylua

      neovim
      neovide
      nerd-fonts.jetbrains-mono

      alejandra
      taplo
      nodePackages.fixjson
    ];

    RUST_BACKTRACE = 1;
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [pkgs.llvmPackages_latest.libclang.lib];

    CONFIG = "${./.}";

    TEST = "${path}";

    shellHook = ''
      export SHELL=$(which fish)
    '';
  }
