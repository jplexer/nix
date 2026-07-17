{
  description = "nix flake!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-flatpak, ... }: {
    nixosConfigurations.holloway = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/holloway

        nix-flatpak.nixosModules.nix-flatpak

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ nix-flatpak.homeManagerModules.nix-flatpak ];

          home-manager.users.jplexer = import ./users/jplexer/home.nix;
        }
      ];
    };
  };
}
