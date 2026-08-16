{ ... }:

{
  imports = [
    ../../modules/common/nix.nix
    ../../modules/common/fonts.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/defaults.nix
    ../../modules/darwin/homebrew.nix
  ];

  networking.hostName = "bagley";
  networking.computerName = "bagley";
  networking.localHostName = "bagley";

  # Apple silicon. Change to "x86_64-darwin" for an Intel Mac.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
