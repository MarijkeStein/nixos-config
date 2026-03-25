# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelModules = [ "sg" ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  fileSystems."/mnt/scratch" = {
    device = "/dev/sdb2";
    fsType = "ext4";
  };

  fileSystems."/pub" = {
    device = "192.168.0.250:/Backup";
    fsType = "nfs";
  };
  fileSystems."/pub/videos" = {
    device = "192.168.0.250:/Multimedia";
    fsType = "nfs";
  };
  boot.supportedFilesystems = [ "nfs" ];


  programs.bash.shellAliases = {
    la = "eza -ahl";
  };

  networking.hostName = "venus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser pkgs.cups-filters pkgs.gutenprint ];
    package = pkgs.cups.overrideAttrs (old: rec {
      version = "2.4.16";
      src = pkgs.fetchFromGitHub {
        owner = "OpenPrinting";
        repo = "cups";
        rev = "v${version}";
        hash = "sha256-Rre2eOIdy61hG8/T5L6YIunxXl8Yn2Yv9W5Apt6L3/E=";
        };
      });
  };

  hardware.printers = {
    ensureDefaultPrinter = "Brother9570";
    ensurePrinters = [
      {
        name = "Brother9570";
        description = "Brother MFC-L9570CDW";
        deviceUri = "ipp://192.168.0.100/ipp/print";
        #model = "everywhere";
        model = "driverless:ipp://192.168.0.100/ipp/print";
        ppdOptions = {
          PageSize = "A4";
          ColorModel = "RGB";
        };
      }
    ];
  };

  systemd.services.cups.after = [ "network-online.target" ];
  systemd.services.cups.wants = [ "network-online.target" ];
  systemd.services.ensure-printers = {
    after = [ "network-online.target" "cups.service" ];
    wants = [ "network-online.target" ];
  };


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.groups.family.gid = 2020;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    pciutils
    tree
    unzip
    usbutils
    wget
    zip

    bluez
    eog
    evince
    gimp
    gnome-terminal
    keepassxc
    mate.mate-calc
    mtpfs
    pinentry-gtk2
    pipewire
    signal-desktop
    system-config-printer
    thunderbird
    totem
    v4l-utils
    vlc
    xdg-desktop-portal-gtk              # e.g. Gtk FileChooser used by various tools
    xfce.thunar-volman

    libsForQt5.qt5ct
    kdePackages.kate
    kdePackages.kconfig
    kdePackages.konsole
    kdePackages.okular
    marksman

    pkgs.backintime-qt
    pkgs.cron
    pkgs.fcron

    hyphen
    hyphenDicts.de_DE
    hyphenDicts.de-de
    libreoffice

    (xsane.override { gimpSupport = true; })

    ungoogled-chromium
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.blueman.enable = true;

  services.dbus.packages = [ pkgs.gcr ];

  services.flatpak.enable = true;

  services.gvfs.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Flatpak + CUPS:
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk
                     pkgs.xdg-desktop-portal-xapp ];
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
