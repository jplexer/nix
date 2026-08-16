{ ... }:

# Declarative macOS `defaults write` settings. These replace poking around in
# System Settings by hand; a `darwin-rebuild switch` reapplies them.
{
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = true;
      tilesize = 46;
      minimize-to-application = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";   # column view
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;  # key repeat over accent popup
    };

    trackpad.Clicking = true;            # tap to click
  };

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
