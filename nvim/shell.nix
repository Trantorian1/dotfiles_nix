{rustVersion ? "1.86.0"}: let
  rustOverlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");

  sources = import ../npins;
  system = builtins.currentSystem;
  pkgs = import sources.nixpkgs {
    inherit system;
    config = {};
    overlays = [rustOverlay];
  };

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
  pkgs.mkShell {
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

      # Rust
      gnumake
      rust
      mdbook
      mdbook-mermaid
      lldb_21
      taplo

      # Nix
      nil
      alejandra

      # Lua
      lua-language-server
      stylua

      linuxPackages.perf
      hotspot

      neovim
      neovide
      nerd-fonts.jetbrains-mono

      nodePackages.fixjson
    ];

    RUST_BACKTRACE = 1;
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.gcc.cc.lib
      pkgs.openssl
    ];
    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [pkgs.llvmPackages_latest.libclang.lib];

    CONFIG = "${./.}";

    shellHook = ''
      export SHELL=$(which fish)
    '';
  }
