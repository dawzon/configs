let
	nixKernel = builtins.fetchurl {
		url = "https://github.com/nix-community/nixos-images/releases/download/nixos-25.05/bzImage-x86_64-linux";
		sha256 = "3cc19d99b564cc8a7b2c551388c3bf430a8823a386f2ca0db9598a8dcae2675c";
	};
	nixInitrd = builtins.fetchurl {
		url = "https://github.com/nix-community/nixos-images/releases/download/nixos-25.05/initrd-x86_64-linux";
		sha256 = "52b02dab33a2f1283daebc849982af9b63ddd8b8d52095ef8cb7206429a88803";
	};
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
		kernel = nixKernel;
		initrd = nixInitrd;
	};
}
