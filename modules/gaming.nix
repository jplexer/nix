{ pkgs, config, ... }:
{
  programs.gamemode.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraPackages = [pkgs.hidapi];
  };

  environment.systemPackages = with pkgs; [
    heroic
    protonup-qt
    prismlauncher
    (pkgs.rpcs3.overrideAttrs (prev: {
      cmakeFlags = prev.cmakeFlags ++ [ (lib.cmakeBool "BUILD_SHARED_LIBS" false) ];
    }))
  ];
}
