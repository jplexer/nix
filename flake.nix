{
  description = "nix flake!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-darwin, nix-flatpak, ... }: {
    # NixOS desktop -- sudo nixos-rebuild switch --flake .#holloway
    nixosConfigurations.holloway = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/holloway

        nix-flatpak.nixosModules.nix-flatpak

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ nix-flatpak.homeManagerModules.nix-flatpak ];

          home-manager.users.jplexer.imports = [
            ./users/jplexer/home.nix
            ./users/jplexer/linux.nix
          ];
        }
      ];
    };

    # MacBook -- darwin-rebuild switch --flake .#bagley
    darwinConfigurations.bagley = nix-darwin.lib.darwinSystem {
      modules = [
        ./hosts/bagley

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.jplexer.imports = [
            ./users/jplexer/home.nix
            ./users/jplexer/darwin.nix
          ];
        }
      ];
    };
  };
}
