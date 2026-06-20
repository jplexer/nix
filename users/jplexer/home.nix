
{ config, pkgs, ... }:

{
  home.username = "jplexer";
  home.homeDirectory = "/home/jplexer";

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
    iotop
    iftop
    
    lsof # list open files

    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    discord
    git-credential-manager
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    extraConfig.credential= {
      helper = "manager";
      credentialStore = "secretservice";
      "https://github.com".username = "jplexer";
    };
    
    settings.user = {
      name  = "Joshua Jun";
      email = "lets@throw.rocks";
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
