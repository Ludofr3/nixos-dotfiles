{ config, pkgs, pkgs-unstable, inputs, ... }:
let
  # Patcher cursor pour qu'il fonctionne sur NixOS
  cursor-patched = pkgs-unstable.code-cursor.overrideAttrs (oldAttrs: {
    postFixup = (oldAttrs.postFixup or "") + ''
      # Patcher les binaires node téléchargés
      wrapProgram $out/bin/cursor \
        --set ELECTRON_OVERRIDE_DIST_PATH ${pkgs.electron}/bin/electron
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    hyprpicker
    docker
    qemu_kvm
    libvirt
    virt-manager
    virt-viewer
    openjdk11
    unzip
    yarn-berry
    nodejs_24
    gnumake
    vim
#    prisma-engines
#    prisma  
    openssl
    pkgs-unstable.brave
  ] ++ [
    cursor-patched
  ];

  # Activer le support des binaires dynamiques pour Cursor
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    nspr
    expat
    libdrm
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    mesa
    pango
    cairo
    alsa-lib
    at-spi2-atk
    at-spi2-core
    cups
    dbus
    glib
    gtk3
    libnotify
    openssl
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  
# environment.sessionVariables = {
#    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
#    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
#    PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
#    PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING = "1";
#    OPENSSL_DIR = "${pkgs.openssl.dev}";
#    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
#  };

#  environment.sessionVariables = {
#    PRISMA_CLI_BINARY_TARGETS = "linux-musl";
#  };
  
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["ludofr3"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
