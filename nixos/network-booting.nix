let
  # nixKernel = builtins.fetchurl {
  # 	url = "https://github.com/nix-community/nixos-images/releases/download/nixos-25.11/bzImage-x86_64-linux";
  # };
  # nixInitrd = builtins.fetchurl {
  # 	url = "https://github.com/nix-community/nixos-images/releases/download/nixos-25.11/initrd-x86_64-linux";
  # };

  pkgs = import <nixpkgs> { };

  clientSystem = import <nixpkgs/nixos> {
    # configuration = ./netboot.nix;
    configuration = ./netboot-gaming.nix;
  };

  build = clientSystem.config.system.build;
in
{
  services.pixiecore = {
    enable = true;
    mode = "boot";
    #mode = "quick";
    #quick = "debian";
    #extraArguments = ["stable"];
    openFirewall = true;
    dhcpNoBind = true;
    # kernel = nixKernel;
    # initrd = nixInitrd;
    # cmdLine = "init=/init root=/dev/ram0 boot.shell_on_fail";
    kernel = "${build.kernel}/bzImage";
    initrd = "${build.netbootRamdisk}/initrd";
    cmdLine = "init=${build.toplevel}/init loglevel=4";
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      		/srv/nfs/gaming 192.168.1.0/24(rw)
      		/srv/nfs/home 192.168.1.0/24(rw)
      		'';
  };
  networking.firewall.allowedTCPPorts = [ 2049 ];
  systemd.tmpfiles.rules = [
    "d /srv/nfs 0755 root root -"
    "d /srv/nfs/gaming 0775 root users -"
    "d /srv/nfs/home 0775 root users -"
  ];
}
