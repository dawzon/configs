{ pkgs, modulesPath, lib, ... }:

{
  imports = [
    # This module handles bundling the Nix store into the initrd
    (modulesPath + "/installer/netboot/netboot-minimal.nix")
  ];

  # Custom Configuration for the client
  networking.hostName = "client-node";

  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-v32b";
  };

  nixpkgs.config.allowUnfree = true;

  #TODO maybe not required?
  boot.supportedFilesystems = [ "nfs" ];

  # fileSystems."/mnt/nfs_gaming" = {
  #   device = "192.168.1.167:/srv/nfs/gaming";
  #   fsType = "nfs";
  # };
  # fileSystems."/home" = {
  #   device = "192.168.1.167:/srv/nfs/home";
  #   fsType = "nfs";
  # };
  fileSystems."/mnt/test_scratch" = {
    device = "/dev/disk/by-uuid/f178c73f-9fb6-4839-8d62-a86ee54d02ae";
    fsType = "ext4";
  };

  environment.systemPackages = with pkgs; [ neovim htop fastfetch ];

  # TODO fix issue with steam library?
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  services = {
    xserver.enable = true;
    # displayManager = {
    #   autoLogin = {
    #     enable = true;
    #     user = "nixos";
    #   };
    #   defaultSession = "steam";
    # };
    desktopManager.gnome.enable = true;
  };

  # Optional: Automatically log in as root for easier debugging
  # services.getty.autologinUser = "root";
  # TODO not sure if this is bad
  # services.getty.autologinUser = lib.mkForce "root";

  # This is required for NixOS configurations
  system.stateVersion = "25.11";
}
