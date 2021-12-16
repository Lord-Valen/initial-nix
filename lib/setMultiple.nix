{ lib, ... }:
with lib;
{
  setMultiple = value: attrList:
    lib.genAttrs attrList ( x: value );
}
