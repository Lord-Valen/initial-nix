{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = config.valen.fortune;

in with lib; {
  options.valen.fortune = {
    enable = mkEnableOption "fortune.enable";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fortune
    ];
  };
}
