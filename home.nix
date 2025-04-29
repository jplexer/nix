{ config, pkgs, system, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  home.username = "jplexer";
  home.homeDirectory = "/home/jplexer";

  home.packages = with pkgs; import ./user-packages.nix { inherit pkgs; };

  programs.git = {
    enable = true;
    userName = "Joshua Jun";
    userEmail = "joshuajun@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "manager";
      credential.credentialStore = "secretservice";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [ -e /run/.containerenv ] || [ -e /.dockerenv ]; then
        PATH=/home/jplexer/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin:$PATH
        export PATH
        source /home/jplexer/emsdk/emsdk_env.sh
      fi
    '';
  };

  programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
  };

  xdg.configFile."containers/policy.json".text = ''
     {
       "default": [{"type": "insecureAcceptAnything"}]
     }
   '';

   xdg.configFile."containers/registries.conf".text = ''
     unqualified-search-registries = ["docker.io"]
   '';

  programs.direnv = {
         enable = true;
         enableBashIntegration = true; # see note on other shells below
         nix-direnv.enable = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
