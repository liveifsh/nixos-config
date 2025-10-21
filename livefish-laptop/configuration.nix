{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./grub.nix
      ./wireguard/wireguard.nix
      ./shadowsocks/shadowsocks.nix
      ./sddm/sddm.nix
      ./jetbrains/jetbrains.nix
      ./services.nix
      ./programs.nix
      ./xdg.nix
      # ./docker/docker-compose.nix
    ];


  security.polkit.enable = true;
  
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; 
      };
    };
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  
  # Use Cachy Os kernel because why not
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # system.modulesTree = [ (lib.getOutput "modules" pkgs.linuxPackages_cachyos.kernel) ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "livefish" ]; # For devenv caches
      auto-optimise-store = true;
      builders-use-substitutes = true;
        
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      
    };
  
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = [ "10:00" ];
    };
  };

  networking = {
    hostName = "livefish-laptop"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  
  system.autoUpgrade = {
    enable = true;  
    dates = "20:00";
  };
  # system.autoUpgrade.allowReboot = true;
  
  nixpkgs.config = {
    permittedInsecurePackages = [
      "fluffychat-linux-1.27.0"
      "olm-3.2.16"  
      "electron-34.5.8"
    ];
    allowUnfree = true;  
  };
  
  fonts.enableDefaultPackages = true; # Basic unicode coverage
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  systemd.services = {
    NetworkManager-wait-online.wantedBy = lib.mkForce [ ];

    "systemd-suspend" = {
      serviceConfig = {
        Environment=''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
      };
    };

    fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "simple";
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
  
  users.users.livefish = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "dialout" "wireshark" "vboxusers" "libvirtd" "scanners" ];
    home = "/home/livefish";
    createHome = true;
  };
  
  # https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
      vim
      wget
      btop-rocm
      git
      firefox
      nix-prefetch-scripts
      which
      fastfetch
      hyprland
      far2l
      killall
      alacritty
      kitty
      gnome-disk-utility
      ncdu
      duf
      cryptsetup
      ntfs3g
      home-manager
      lshw
      ntp

      vulkan-tools

      wayland-utils # Wayland utilities  
      wl-clipboard # Command-line copy/paste utilities for Wayland
      wl-clip-persist
  
      wofi
      
      bat
      vlc
      qimgv # Image viewer

      sshfs
      ffmpeg
      
      xdg-terminal-exec
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-wlr
      door-knocker
      
      shared-mime-info
            
      gparted 
      polkit
      
      # Sound
      alsa-utils
      pavucontrol
      pamixer
      qpwgraph
      bluez
      bluez-tools

      btrfs-progs
      hyprpolkitagent

      amnezia-vpn

      # Epic games
      legendary-gl
      rare

      meld # Merge diffs
           
      hardinfo2

      undetected-chromedriver
      chromium

      font-awesome

      playerctl # for pause buttons on keyboard and handphones
      brightnessctl
      
      mlocate # locate and so on

      themechanger # GTK theme manager

      drawpile # Colloborative drawing
      
      freecad

      hydralauncher # Game launcher with built-in torrent client

      calc # Why haven't I added it before

      arduino-ide

      httpie
      sqlmap

      obsidian

      # Wine
      wineWowPackages.staging
      winetricks
      wineWowPackages.waylandFull

      openssl.dev

      devenv
      direnv
      
      thunderbird
      birdtray

      networkmanager_dmenu
      
      # FHS (https://discourse.nixos.org/t/tips-tricks-for-nixos-desktop/28488/2)
      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in 
        pkgs.buildFHSEnv (base // {
         name = "fhs";
         targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [pkgs.pkg-config]; 
         profile = "export FHS=1"; 
         runScript = "bash"; 
         extraOutputsToInstall = ["dev"];
        }))

      # virtualbox
      # linuxKernel.packages.linux_6_17.virtualbox
      quickemu
    
      gping
      testdisk
      exiftool

      testdisk-qt
      
      audacity
        
      rar
      p7zip      
    
      icu      
    
      wayland-pipewire-idle-inhibit # Prevent suspend when audio is playing
      
      kdePackages.dolphin
      kdePackages.ark      
      kdePackages.kate # text editor
      kdePackages.qtsvg            # Dolphin svg icons support
      kdePackages.kio-fuse         # to mount remote filesystems via FUSE
      kdePackages.kio-extras       # extra protocols support (sftp, fish and more)
      kdePackages.plasma-workspace # File associations in dolphin open with window
      kdePackages.kdeconnect-kde   # Kde connect daemon

      avahi
  
      # Hacker tools
      nmap
      wireshark
      cyberchef
      busybox  # telnet and so on

      # Sqlite viewer
      termdbms

      # Db viewer
      dbeaver-bin

      inputs.agenix.packages."${system}".default
      inputs.sddm-stray.packages.${pkgs.system}.default
      inputs.prismlauncher-cracked.packages."${system}".default
      inputs.compose2nix.packages.${system}.default
  ]; 

  networking.firewall = rec {
    enable = true;
    checkReversePath = false; # Wireguard
    allowedTCPPorts = [ 22 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 51820; to = 51830; }
    ] ++ allowedTCPPortRanges;
  };
  
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "livefish" ];
  #virtualisation.virtualbox.host.enableExtensionPack = true;


  # Never modify!
  system.stateVersion = "25.05";
}
