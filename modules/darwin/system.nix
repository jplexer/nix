{ pkgs, ... }:

{
  # nix-darwin needs to know which account user-scoped options (defaults,
  # homebrew, home-manager activation) belong to.
  system.primaryUser = "jplexer";

  users.users.jplexer = {
    home = "/Users/jplexer";
    shell = pkgs.zsh;
  };

  time.timeZone = "Europe/Berlin";

  # launchd equivalent of the systemd timer used on NixOS: Sunday 03:00.
  nix.gc.interval = {
    Weekday = 0;
    Hour = 3;
    Minute = 0;
  };

  environment.systemPackages = with pkgs; [
    git
    gh
    helix
    nil
    nixd
    nodejs_26
    pnpm
  ];

  # The shared home-manager config manages the shell and Starship prompt.
  programs.zsh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # This is nix-darwin's OWN state version counter. It is NOT the same scheme
  # as NixOS's system.stateVersion or home-manager's home.stateVersion
  # (both "26.05" here) -- do not "fix" it to look like those.
  system.stateVersion = 6;
}
