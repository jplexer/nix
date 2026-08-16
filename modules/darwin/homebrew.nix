{ ... }:

# Declarative Homebrew. nix-darwin does NOT install brew itself -- run the
# official installer once on a fresh machine, then this module keeps the
# installed set in sync via `brew bundle`.
#
# This is here for things nixpkgs cannot provide on darwin: Mac-only apps, and
# packages whose darwin build is missing (vlc, hexchat) or that behave better
# as a signed .app bundle (browsers, anything wanting a system extension).
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "none" leaves manually-installed brew packages alone. Switch to
      # "uninstall" (or "zap", which also removes config) once you trust the
      # lists below to be complete -- it will then remove anything not listed.
      cleanup = "none";
    };

    brews = [
    ];

    casks = [
      "linearmouse"
      "monal"
      "fork"
      "claude"
      "transmit"
      "helium-browser"
      "littlesnitch@nightly"
      "typewhisper"
      "docker-desktop"
      "backblaze"
      "proton-mail-bridge"
      "proton-drive"
      "camo-studio"
      "ente-auth"
      "tailscale-app"
      "zoom"
      "hyperkey"
      "nrf-connect"
      "orcaslicer"
      "saleae-logic"
      "steam"
      "intellij-idea"
    ];

    # Mac App Store apps, needs the `mas` CLI (add "mas" to brews above).
    masApps = {
    };
  };
}
