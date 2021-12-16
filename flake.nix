{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixt = {
      url = "github:nix-community/nixt/typescript-rewrite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ldlework = {
      url = "github:dustinlacewell/dotfiles.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    with import ./utils {};
    {
      nixosConfigurations = let
        localModules = recImport ./modules;
      in {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # the system architecture
          modules = localModules ++ inputs.ldlework.nixosModules ++ [
            home-manager.nixosModules.home-manager
            ./hosts/x86_64-linux/nixos
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lord-valen = import ./hosts/x86_64-linux/nixos/home.nix;
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
