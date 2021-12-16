{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = config.ldlework.vm;

in with lib; {
  imports = [ (modulesPath + "/virtualisation/qemu-vm.nix") ];

  options.ldlework.vm = {
    enable = mkEnableOption "vm.enable";
    graphical = mkEnableOption "vm.graphical";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      memorySize = 1024;
      graphics = cfg.graphical;
    };
  } // mkIf cfg.graphical {
    services.xserver = {
      enable = true;

      displayManager = {
        autoLogin = {
          enable = true;
          user = "ldlework";
        };
      };
    };
  };
}
