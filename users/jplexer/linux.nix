{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/jplexer";

  home.packages = with pkgs; [
    iotop
    iftop
    sysstat
    lm_sensors
    ethtool
    vlc
    hexchat
    temurin-bin
    claude-code
    pinta
    discord
    zed-editor
    signal-desktop
    audacity
  ];

  programs.git.settings.credential.credentialStore = "secretservice";

  services.flatpak.packages = [
    "com.mastermindzh.tidal-hifi"
    "org.pipewire.Helvum"
  ];
}
