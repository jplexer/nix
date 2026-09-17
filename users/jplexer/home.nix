{ config, pkgs, ... }:

# Portable home-manager config, imported on both holloway (NixOS) and
# bagley (macOS). Anything that only builds on one platform belongs in
# ./linux.nix or ./darwin.nix instead.
{
  home.username = "jplexer";

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

    lsof # list open files

    pciutils
    usbutils

    git-credential-manager
    uv
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      # Up/Down search history for commands starting with the typed prefix,
      # then place the cursor at the end of the recalled command.
      autoload -Uz history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end

      # Cover both normal and application-mode terminal arrow sequences.
      for keymap in emacs viins; do
        bindkey -M "$keymap" '^[[A' history-beginning-search-backward-end
        bindkey -M "$keymap" '^[[B' history-beginning-search-forward-end
        bindkey -M "$keymap" '^[OA' history-beginning-search-backward-end
        bindkey -M "$keymap" '^[OB' history-beginning-search-forward-end
      done
      unset keymap
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      credential = {
        helper = "manager";
        # credentialStore differs per platform, see ./linux.nix and ./darwin.nix
        "https://github.com".username = "jplexer";
      };

      user = {
        name  = "Joshua Jun";
        email = "lets@throw.rocks";
      };
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
