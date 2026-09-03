{ config, pkgs, ... }:

{
  home.homeDirectory = "/Users/jplexer";

  home.packages = with pkgs; [
    iftop
  ];

  # git-credential-manager stores secrets in the login keychain on macOS;
  # the secretservice backend used on NixOS does not exist here.
  programs.git.settings.credential.credentialStore = "keychain";

  # Was the only customisation in the hand-written ~/.zshrc that home-manager
  # now generates.
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.bun/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  # On NixOS zsh/oh-my-zsh is set up system-wide in modules/linux/system.nix.
  # nix-darwin has no ohMyZsh option, so it is configured per-user here.
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };
}
