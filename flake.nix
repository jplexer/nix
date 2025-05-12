{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
        # to have it up-to-date or simply don't specify the nixpkgs input
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.holloway = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common-configuration.nix
        ./systems/holloway/configuration.nix # holloway specific configuration
        home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jplexer = ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
              home-manager.backupFileExtension = "backup";
            }
      ];
    };
  };
}
