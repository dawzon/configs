# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./network-booting.nix
  ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
    consoleMode = "max";
    windows = {
      "11" = {
        title = "Windows 11";
        efiDeviceHandle = "HD0c";
        sortKey = "0";
      };
    };
    edk2-uefi-shell.enable = true;
    memtest86.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "impetus-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dawson = {
    isNormalUser = true;
    description = "Dawson Coleman";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #Development Tools
    tree-sitter
    gcc
    cargo
    go
    gnumake
    ripgrep
    fzf
    fd
    wget
    python314
    nodejs_22
    unzip
    fish
    powershell
    clang
    cmake
    nixfmt
    tldx
    twitch-cli
    jq
    zstd
    podman-desktop

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
    kooha

    #Desktop apps
    alacritty
    pavucontrol
    google-chrome
    discord
    vlc
    reaper
    #davinci-resolve
    blender
    handbrake
    spotify
    pinta
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
      mplayer = super.mplayer.override { v4lSupport = true; };
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
      polkitPolicyOwners = [ "dawson" ];
    };
    nm-applet.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    git = {
      enable = true;
      config = {
        pull = {
          ff = "only";
        };
      };
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

  xdg.portal.xdgOpenUsePortal = true;

  # Dark mode
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "Adwaita-dark";
          };
        };
      }
    ];
  };

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
  services.blueman.enable = true;

  services.hypridle = {
    enable = true;
  };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  #     	user = "greeter";
  #     };
  #   };
  # };

  services.playerctld.enable = true;

  virtualisation = {
    podman = {
      enable = true;
    };
  };

  hardware.wooting.enable = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than +5";
  };
  nix.settings = {
    experimental-features = [ "nix-command" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
