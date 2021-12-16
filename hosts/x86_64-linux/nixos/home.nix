{ pkgs, ... }:

{
  valen.fortune.enable = true;
  home.packages = [ pkgs.htop ];
}
