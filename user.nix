{
  config,
  pkgs,
  option,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.trantorian = {
    isNormalUser = true;
    description = "trantorian";
    extraGroups = ["networkmanager" "wheel" "video" "docker" "libvirtd"];
    packages = with pkgs; [
      # Estonian e-identity
      qdigidoc
      web-eid-app
      p11-kit
      opensc
    ];
  };

  # Estonian e-identity
  # See https://nixos.wiki/wiki/Web_eID
  # for more information
  services.pcscd.enable = true;
  environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';
  environment.etc."chromium/native-messaging-hosts/eu.webeid.json".source = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";
  environment.etc."opt/chrome/native-messaging-hosts/eu.webeid.json".source = "${pkgs.web-eid-app}/share/web-eid/eu.webeid.json";
  environment.systemPackages = with pkgs; [
    # Wrapper script to tell to Chrome/Chromium to use p11-kit-proxy to load
    # security devices, so they can be used for TLS client auth.
    # Each user needs to run this themselves, it does not work on a system level
    # due to a bug in Chromium:
    #
    # https://bugs.chromium.org/p/chromium/issues/detail?id=16387
    (pkgs.writeShellScriptBin "setup-browser-eid" ''
      NSSDB="''${HOME}/.pki/nssdb"
      mkdir -p ''${NSSDB}

      ${pkgs.nssTools}/bin/modutil -force -dbdir sql:$NSSDB -add p11-kit-proxy \
        -libfile ${pkgs.p11-kit}/lib/p11-kit-proxy.so
    '')
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
