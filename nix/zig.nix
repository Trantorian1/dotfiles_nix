{pkgs, ...}: let
  zig = pkgs.stdenv.mkDerivation {
    pname = "zig";
    version = "0.16.0-dev.1316+181b25ce4";

    src = pkgs.fetchurl {
      url = "https://ziglang.org/builds/zig-x86_64-linux-0.16.0-dev.1316+181b25ce4.tar.xz";
      sha256 = "sha256-PFr0YhfIf8O16U4l6miIJpDIJJWurHAoIw9pAl+SzUc=";
    };

    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out/{doc,bin,lib}
      [ -d docs ] && cp -r docs/* $out/doc
      [ -d doc ] && cp -r doc/* $out/doc
      cp -r lib/* $out/lib
      cp zig $out/bin/zig
    '';
  };
in {
  environment.systemPackages = [zig];
}
