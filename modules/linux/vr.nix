{ pkgs, config, ... }:
{
  services.wivrn = {
    enable = true;
    openFirewall = true;
    autoStart = true;
  };
}
