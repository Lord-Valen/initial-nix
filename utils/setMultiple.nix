{ lib }:
with lib;
let
  setMultiple = value: attrList:
    lib.genAttrs attrList ( x: value );
in setMultiple
