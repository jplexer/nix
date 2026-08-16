{ config, pkgs, ... }:

# Portable home-manager config, imported on both holloway (NixOS) and
# bagley (macOS). Anything that only builds on one platform belongs in
# ./linux.nix or ./darwin.nix instead.
{
  home.username = "jplexer";

  home.packages = with pkgs; [
    fastfetch
    hyfetch

    zip
    xz
    unzip
    p7zip

    ripgrep

    dnsutils
    aria2
    ipcalc

    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    btop

    lsof # list open files

    pciutils
    usbutils

    discord
    git-credential-manager
    zed-editor
    uv
    signal-desktop
    pinta
    audacity
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      credential = {
        helper = "manager";
        # credentialStore differs per platform, see ./linux.nix and ./darwin.nix
        "https://github.com".username = "jplexer";
      };

      user = {
        name  = "Joshua Jun";
        email = "lets@throw.rocks";
      };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
