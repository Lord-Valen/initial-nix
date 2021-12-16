{ config, pkgs, lib, inputs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  ldlework.vm = {
    enable = true;
    graphical = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  time.timeZone = "Canada/Eastern";

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      windowManager.xmonad = setMultiple true [
        "enable"
        "enableContribAndExtras"
      ];
      xkbVariant = "colemak_dh";
      xkbOptions = "shift:both_capslock";
    };
  };

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [
                              "Inconsolata"
                              "LiberationMono"
                              "Noto"
                              "Ubuntu"
                            ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Inconsolata" ];
        emoji = [ "Noto" ];
      };
    };
  };

  users.users.lord-valen = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
    initialPassword = "password";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    brave
    kitty
    discord
    xclip
    rofi
    inputs.nixt.defaultPackage.x86_64-linux
  ];
  system.stateVersion = "21.11"; # Did you read the comment?
}
