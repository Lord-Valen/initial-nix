{  lib, ... }:
with lib;
with ./recImport.nix;
{
  imports = recImport ./.;
}
#with ./recImport.nix;
#{
#  imports = recImport ./.;
#}
#    let
#  util = import ./recImport.nix;
#in util.recImport ./.
