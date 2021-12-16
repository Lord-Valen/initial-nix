{ lib }:
with lib;
let
  enableMultiple = list:
    lib.genAttrs list (x:
      { enable = true; });

in enableMultiple
