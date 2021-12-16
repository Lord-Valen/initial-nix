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

  outputs = inputs@{ self, nixpkgs, home-manager, ldlework, ... }:
    let
      lib = nixpkgs.lib.extend (self: super: {mine = import ./lib { lib = self; }; });
      pkgs = import nixpkgs {
        inherit system;
        config = { allowBroken = true; allowUnfree = true; };
      };
      system = "x86_64-linux";
    in
      with lib;
      with lib.mine; {
        nixosConfigurations = let
          localModules = recImport ./modules;
        in {
          nixos = nixosSystem {
            inherit system;
            modules = localModules ++ ldlework.nixosModules ++ [
              home-manager.nixosModules.home-manager
              ./hosts/${system}/nixos
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.lord-valen = import ./hosts/${system}/nixos/home.nix;
              }
            ];
            specialArgs = { inherit inputs; };
          };
        };
      };
}
