{ pkgs, ... }:
with pkgs; [
  (pkgs.writeShellScriptBin "dotnet-distrobox" ''
        #!/usr/bin/env bash
        exec distrobox enter dotnetbox -- dotnet "$@"
      '')
  dotnet-sdk_9
  dotnet-runtime_9
  go
  atproto-goat
  ffmpeg

  beeper
  calibre
  cinny
  insomnia
  obs-studio
  termius
  jamesdsp

  pnpm
  nodejs
  fontconfig

  ngrok
  podman
  podman-compose
  distrobox
  cachix

  #discord
  (pkgs.discord.override { withMoonlight = true; })

  #jetbrains
  jetbrains.webstorm
  jetbrains.rider
  jetbrains.rust-rover
  jetbrains.idea-ultimate

  kdePackages.kate
  zed-editor
  vscode

  # archives
  zip
  xz
  unzip
  p7zip

  # networking tools
  mtr # A network diagnostic tool
  iperf3
  dnsutils  # `dig` + `nslookup`
  aria2 # A lightweight multi-protocol & multi-source command-line download utility

  # misc
  file
  which
  tree
  gnused
  gnutar
  gawk
  zstd
  gnupg

  # nix related
  #
  # it provides the command `nom` works just like `nix`
  # with more details log output
  nix-output-monitor

  btop  # replacement of htop/nmon
  iotop # io monitoring
  iftop # network monitoring

  # system call monitoring
  strace # system call monitoring
  ltrace # library call monitoring
  lsof # list open files

  # system tools
  sysstat
  ethtool
  pciutils # lspci
  usbutils # lsusb

  git-credential-manager
]
