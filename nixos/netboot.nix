{ pkgs, modulesPath, lib, ... }:

{
  imports = [
    # This module handles bundling the Nix store into the initrd
    (modulesPath + "/installer/netboot/netboot-minimal.nix")
  ];

  # Custom Configuration for the client
  networking.hostName = "client-node";

  console = {
  	packages = [pkgs.terminus_font];
	font = "ter-v32b";
  };
  
  # Add your custom packages
  environment.systemPackages = with pkgs; [ 
    git 
    neovim 
    htop 
    fastfetch
  ];

  # Enable SSH so you can reach the machine after it boots
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true; # Or add your SSH keys
  };

  # Optional: Automatically log in as root for easier debugging
  # services.getty.autologinUser = "root";
  # TODO not sure if this is bad
  services.getty.autologinUser = lib.mkForce "root";

  # This is required for NixOS configurations
  system.stateVersion = "25.11"; 
}
