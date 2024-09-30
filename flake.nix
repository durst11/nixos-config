{
  description = "JRD simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Cosmic Desktop
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; 
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-cosmic, ... }: {
    # hostname
    nixosConfigurations = {
      nix-t560 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager config will be deployed automatically
          # when executing 'nixos-rebuild switch'
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jeremy = import ./home.nix;
          }
        ];
      };
    };
  };
}
