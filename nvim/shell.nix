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
  # TODO: it would be cool if we could turn this into an actual derivation.
  # We can use `pkgs.writeShellApplication` to abstract away some of the
  # complexities of calling Neovide, along with file sets (https://nix.dev/tutorials/working-with-local-files)
  # to handle copying the lua source files into the nix store. There probably
  # still is a lot of complexity I am not aware of, but that would be start in
  # the right direction. Ideally we would like for it to be possible to bundle
  # this config as a nix package, and maybe upload it to the nix store? Although
  # given the nature of this as a personal work environment, I would feel more
  # comfortable just hosting the code on github for something like `nix run` to
  # pick up. We'll see :)
  pkgs.mkShell {
    packages = with pkgs; [
      # busybox
      cacert
      pkg-config
      openssl
      xclip
      git
      fish
      htop
      ripgrep
      unixtools.xxd

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

      # TS
      typescript
      typescript-language-server
      prettierd
      nodePackages.prettier

      # yaml
      yaml-language-server

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
