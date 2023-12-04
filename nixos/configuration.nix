{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
	  systemd-boot.enable = true;
	  efi.canTouchEfiVariables = true;
  };

  networking.hostName = "friday"; 

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  # networking.interfaces.enp2s0.useDHCP = true;

  # networking.defaultGateway = "192.168.0.1";
  # networking.nameservers = [ "8.8.8.8" ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.extraHosts =
  ''
    # --------------------
    # Block unwated sites
    # --------------------

    #127.0.0.1 youtube.com www.youtube.com
    #::1 youtube.com www.youtube.com

    #127.0.0.1 9gag.com www.9gag.com
    #::1 9gag.com www.9gag.com

    #127.0.0.1 reddit.com www.reddit.com
    #::1 reddit.com www.reddit.com
  '';

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # ====================
    # Libraries
    # ====================

    binutils
    bison
    gnupg
    libtool
    libxml2
    libxslt
    libyaml
    readline		# Library for interactive line editing

    # ====================
    # X Window Server && Friends
    # ====================

    compton		# A fork of XCompMgr, a sample compositing manager for X servers
    conky
    rofi
    dzen2
    feh			# A light-weight image viewer
    xclip		# Tool to access the X clipboard from a console application
    xorg.xev 		# print content of X events
    xorg.xkbcomp 	# compile XKB keyboard description
    xorg.xdpyinfo	# Display information about X server

    # ====================
    # Terminal, editors
    # ====================
    
    ag               	# Silver-searcher-2.2.0  A code-searching tool similar to ack, but faster  
    alacritty
    autojump		# A 'cd' command that learns
    emacs
    fzf			# A command-line fuzzy finder
    neofetch		# A fast, highly customizable system info script
    neovim
    tmate
    tmux
    vim

    # ====================
    # Compilers
    # ====================

    ghc			# The Glasgow Haskell Compiler
    gcc
    automake
    nodejs
    v8
    ruby
    stack		# The Haskell Tool Stack

    # ====================
    # Tools 
    # ====================

    autoconf		# Part of the GNU Build System
    bash
    curl
    docker
    docker_compose
    gitAndTools.gitFull
    gnumake		# A tool to control the generation of non-source files from sources
    gotop 		# A terminal based graphical activity monitor inspired by gtop and vtop
    htop
    insomnia  		# The most intuitive cross-platform REST API Client 
    lsof
    openssl
    parted
    patch		# GNU Patch, a program to apply differences to files
    pkgconfig		# A tool that allows packages to find out information about other packages
    pv
    redshift
    sqlite
    wget 
    zip
    zlib

    # ====================
    # Browsers
    # ====================

    brave
    chromium
    firefox

    # ====================
    # Communication
    # ====================

    discord
    skype
    slack
    irssi

    # ====================
    # Tools
    # ====================

    dbeaver

    # ====================
    # Fun
    # ====================

    steam
    spotify
    vlc

    simplescreenrecorder
    minecraft
    minecraft-server

    # ====================
    # Others
    # ====================

    libpqxx # pg dependency

  ];

  fonts.fonts = with pkgs; [
    inconsolata
    fira-code
    fira-code-symbols
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  # Shell script called during bash shell initialization
  programs.bash.interactiveShellInit = ''
  '';
  
  programs.bash.shellAliases = {
    # --------------------
    # Misc
    # --------------------
    ".." = "cd ..";

    vim = "nvim";

    nixos--conf = "vim /etc/nixos/configuration.nix";
    nixos--conf-hardware = "vim /etc/nixos/hardware-configuration.nix";

    nix--search = "nix-env -qaP --description";
    nix--list-installed = "nix-env -q --installed";

    mount--usb = "mount /dev/sdc1 /media/usb";
    umount--usb = "umount /media/usb";

    system--clean = "nix-collect-garbage -d";
    system--update = "nix-channel --update";
    system--upgrade = "nixos-rebuild switch && cp /etc/nixos/configuration.nix /home/cr0xd/main/projects/_ongoing/dotfiles/nixos/configuration.nix && chown -R cr0xd: /home/cr0xd/main/projects/_ongoing/dotfiles/nixos/configuration.nix";
    system--test = "nixos-rebuild test";

    system--shutdown= "shutdown now";
    system--reboot= "reboot";
    system--hibernate = "systemctl hibernate";
    system--suspend = "systemctl suspend";
  };

  # xserver
  services.xserver.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.resolutions = [ { x = 1920; y = 1080; } ];
  services.xserver.displayManager.defaultSession = "none+xmonad";

  # display manager
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.autoLogin = { enable = true; user = "cr0xd"; };
  
  # xkb
  services.xserver.autoRepeatDelay = 250; 	# you can tests those values by using: `xset r rate 250 30`
  services.xserver.autoRepeatInterval = 30;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  # audio
  sound.enable = true;
  sound.mediaKeys = {
    enable = true;
    volumeStep = "5%";
  };

  # pulseaudio requires adding "audio" group to extraGroups
  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  #   package = pkgs.pulseaudioFull;
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cr0xd = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = [ ];
  };

  # programs
  services.urxvtd.enable = true;
  services.deluge.enable = true;

  # nixpkgs.config.chromium.enableWideVine = true;

  # docker
  virtualisation.docker.enable = true; 

  # gpg
  programs.gnupg.agent.enable = true;

  # postgresql
  #services.postgresql.enable = true;
  #services.postgresql.package = pkgs.postgresql_11;



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
