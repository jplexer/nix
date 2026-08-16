{ lib, ... }:

# Settings that apply identically to NixOS and nix-darwin.
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
      # The *schedule* is platform specific: NixOS uses systemd timers
      # (nix.gc.dates), darwin uses launchd (nix.gc.interval). See the
      # respective modules/linux and modules/darwin files.
    };
  };
}
