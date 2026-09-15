{ config, pkgs, lib, ... }:

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
    "$HOME/.docker/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  # Docker Desktop installs zsh completion files here for manual installs.
  # Add them to fpath before home-manager runs compinit.
  programs.zsh.initContent = lib.mkOrder 550 ''
    if [[ -d "$HOME/.docker/completions" ]]; then
      fpath=("$HOME/.docker/completions" $fpath)
    fi
  '';
}
