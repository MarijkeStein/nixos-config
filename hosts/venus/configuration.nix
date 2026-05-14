{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.kernelModules = [ "sg" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "nfs" ];

  console.keyMap = "de";

  environment.systemPackages = with pkgs; [
    # base utilities
    bat
    bottom
    curl
    eza
    file
    git
    gnupg
    htop
    killall
    mc
    mmv
    ox
    pciutils
    smartmontools
    tree
    unzip
    usbutils
    wget
    zellij
    zip

    # user applications and utilities
    blueman
    bluez
    eog
    evince
    gimp
    gnome-terminal
    gnomeExtensions.bluetooth-battery-meter
    gparted
    keepassxc
    mate.mate-calc
    mtpfs
    pinentry-gtk2
    pulseaudio
    system-config-printer
    thunderbird
    totem
    v4l-utils
    vlc
    xdg-desktop-portal-gtk              # e.g. Gtk FileChooser used by various tools
    xfce.thunar-volman

    # KDE tools
    kdePackages.kate
    kdePackages.kconfig
    kdePackages.konsole
    kdePackages.okular
    libsForQt5.qt5ct
    marksman

    # Backup
    pkgs.backintime-qt
    pkgs.cron
    pkgs.fcron

    # Office and fonts
    hyphen
    hyphenDicts.de_DE
    hyphenDicts.de-de
    libreoffice

    # LaTeX
    tex-fmt
    texliveTeTeX
    gnumake

    # Scanner support
    (xsane.override { gimpSupport = true; })

    # Unfree software
    ungoogled-chromium
  ];

  fileSystems."/mnt/scratch" = {
    device = "/dev/sdb2";
    fsType = "ext4";
  };

  fileSystems."/pub" = {
    device = "192.168.0.250:/Backup";
    fsType = "nfs";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.printers = {
    ensureDefaultPrinter = "Brother9570";
    ensurePrinters = [
      {
        name = "Brother9570";
        description = "Brother MFC-L9570CDW";
        deviceUri = "ipp://192.168.0.100:631/ipp/print";
        model = "everywhere";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  networking.hostName = "venus";
  networking.networkmanager.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
#     package = pkgs.lix;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 90d";
    persistent = true;
    randomizedDelaySec = "3h";
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash.shellAliases = {
    la = "eza -ahl";
  };

  programs.firefox.enable = true;

  programs.fish.shellAliases = {
    la = "eza -ahl";
  };

  security.rtkit.enable = true;

  services.blueman.enable = true;

  services.flatpak.enable = true;

  services.gvfs.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-filters pkgs.gutenprint ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.pulseaudio.enable = false;

  services.smartd.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "daily";
    randomizedDelaySec = "30min";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  time.timeZone = "Europe/Berlin";

  users.groups.family.gid = 2020;

  users.users.marijke = {
    uid = 2020;
    group = "family";
    isNormalUser = true;
    description = "Marijke Stein";
    extraGroups = [ "cdrom" "lp" "networkmanager" "scanner" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-xapp ];
}
