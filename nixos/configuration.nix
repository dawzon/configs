# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network-booting.nix
    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
    consoleMode = "max";
    windows = {
      "10" = {
	 title = "Windows 10";
	 efiDeviceHandle = "HD0c";
	 sortKey = "0";
      };
    };
    edk2-uefi-shell.enable = true;
    memtest86.enable = true;
  };

  # boot.plymouth = {
  #   enable = true;
  #   theme = "details";
  # };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_17;

  networking.hostName = "impetus-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # services.getty.greetingLine = "NixOS, btw";
  services.getty.greetingLine = builtins.readFile ./greetingLine;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dawson = {
    isNormalUser = true;
    description = "Dawson Coleman";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #Development Tools
    neovim
    tree-sitter
    git
    gcc
    cargo
    go
    gnumake
    ripgrep
    fzf
    fd
    wget
    python3Full
    nodejs_22
    unzip
    fish
    powershell
    podman
    #podman-desktop
    clang
    cmake

    #Utility
    ffmpeg
    yt-dlp
    xorg.xlsclients

    #Terminal bling
    fastfetch
    htop
    cava
    twitch-tui
    kitty

    #Desktop
    wofi
    waybar
    hyprpaper
    hackneyed
    wl-clipboard
    grim
    slurp
    emote
    kdePackages.dolphin
    blueman
    mplayer
    v4l-utils

    #Desktop apps
    alacritty
    pavucontrol
    google-chrome
    discord
    audacity
    vlc
    reaper
    davinci-resolve
    blender
    handbrake
    spotify
    pinta
    krita
    libreoffice
    kdePackages.filelight
    boatswain
    streamcontroller
    prusa-slicer
    mpv
    easyeffects

    #Wine
    wineWowPackages.full

    #Fun
    prismlauncher
  ];

  nixpkgs.config = {
    packageOverrides = super: {
      mplayer = super.mplayer.override {
      	v4lSupport = true;
      };
    };
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    hyprlock = {
    	enable = true;
    };
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      #not sure if this is needed but it was on the nixos wiki
      #https://wiki.nixos.org/wiki/1Password
      polkitPolicyOwners = ["dawson"];
    };
    steam.enable = true;
    nix-ld.enable = true; 
    xwayland.enable = true;
    obs-studio = {
    	enable = true;
	enableVirtualCamera = true;
	plugins = with pkgs.obs-studio-plugins; [
		wlrobs
		obs-backgroundremoval
		obs-vkcapture
	];
    };
    appimage = {
      enable = true;
    };
  };

  fonts.packages = with pkgs; [
    geist-font
    monaspace
    font-awesome
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  xdg.portal.xdgOpenUsePortal = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    #https://discourse.nixos.org/t/pipewire-host-not-found-and-is-inactive/41533
    #systemWide = true;
  };

  #services.desktopManager.cosmic.enable = true;

  services.hypridle = {
    	enable = true;
    };
  #not working with hyprland uwsm for some reason (1.0.3)
  #services.displayManager.ly.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  #     	user = "greeter";
  #     };
  #   };
  # };

  #services.spotifyd.enable = true;

  #services.playerctld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
