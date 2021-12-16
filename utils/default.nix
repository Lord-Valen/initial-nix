{ lib, ... }:
with import ./recImport.nix { };
with lib;
  let
    utilPackages = map (x: callPackage (import x) {}) (recImport ./.);
  in utilPackages
