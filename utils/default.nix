with import ./recImport {};
with lib;
  let
    utilPackages = map (x: callPackage (import x) {}) (recImport ./.);
  in utilPackages
