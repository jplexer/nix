{ config, lib, pkgs, ... }:

{
  users.users."jplexer" = {
    isNormalUser = true;
    description = "Joshua Jun";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.firefox.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  # Shared nix settings (allowUnfree, flakes, gc policy) live in
  # modules/common/nix.nix. Only the systemd-timer schedule is Linux specific.
  nix.gc.dates = lib.mkDefault "weekly";

  environment.systemPackages = with pkgs; [
    git
    helix
    appimage-run
    (chromium.override { enableWideVine = true; })
    distrobox
    android-tools
 ];

  programs.direnv.enable = true;

  # The font package list is shared, see modules/common/fonts.nix.
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  programs.nix-ld.enable = true;
  # Needed for Sailfish SDK
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib at-spi2-atk at-spi2-core atk cairo cups curl dbus expat
    fontconfig freetype fuse3 gdk-pixbuf glib gtk3 icu libGL
    libappindicator-gtk3 libdrm libglvnd libnotify libpulseaudio
    libunwind libusb1 libuuid libxkbcommon libxml2 mesa nspr nss
    openssl pango pipewire stdenv.cc.cc systemd vulkan-loader
    xorg.libX11 xorg.libXScrnSaver xorg.libXcomposite xorg.libXcursor
    xorg.libXdamage xorg.libXext xorg.libXfixes xorg.libXi
    xorg.libXrandr xorg.libXrender xorg.libXtst xorg.libxcb
    xorg.libxkbfile xorg.libxshmfence xorg.xcbutilwm xorg.xcbutilimage
    xorg.xcbutilrenderutil xorg.xcbutilkeysyms xorg.libSM xorg.libICE
    zulu8 harfbuzz zlib
    ncurses libtiff wayland
  ];

  services.flatpak.enable = true;
  programs.ssh.startAgent = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "jplexer" ];
  virtualisation.docker.enable = true;
  users.extraGroups.adbusers.members = ["jplexer"];
}
