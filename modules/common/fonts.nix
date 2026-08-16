{ pkgs, ... }:

# fonts.packages exists on both NixOS and nix-darwin.
# fontconfig settings are Linux-only and live in modules/linux/system.nix.
{
  fonts.packages = with pkgs; [
    # icon fonts
    material-design-icons

    # normal fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # nerdfonts
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
    nerd-fonts.symbols-only # symbols icon only
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];
}
