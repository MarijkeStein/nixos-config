{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "nfs" ];

  console.keyMap = "de";

  environment.systemPackages = with pkgs; [
    # base utilities
    bat
    bottom
    curl
    eza
    file
    fish
    git
    gnupg
    htop
    killall
    mc
    mmv
    nfs-utils
    ox
    pciutils
    smartmontools
    tree
    unzip
    usbutils
    yazi
    wget
    zellij
    zip

    # user applications and utilities
    blueman
    bluez
    eog
    evince
    fcron
    gimp
    gnome-terminal
    gnomeExtensions.bluetooth-battery-meter
    gparted
    keepassxc
    libwebp
    mate.mate-calc
    mtpfs
    pinentry-gtk2
    pipewire
    system-config-printer
    thunderbird
    totem
    v4l-utils
    vlc
    xdg-desktop-portal-gtk              # e.g. Gtk FileChooser used by various tools
    xfce.thunar-volman

    # KDE tools
    libsForQt5.qt5ct
    kdePackages.kate
    kdePackages.kconfig
    kdePackages.konsole
    kdePackages.okular
    marksman

    # Backup
    pkgs.backintime-qt
    pkgs.cron
    pkgs.fcron

#     hyprland
#     kitty
#     waybar
#     mako
#     hyprpaper
#     hyprlock
#     rofi

    # Office and fonts
    hyphen
    hyphenDicts.de_DE
    hyphenDicts.de-de
    libreoffice

    # Development
    gnumake
    gcc
    fontconfig
    pkg-config

    # FIDO2
    ccid
    nitrokey-udev-rules
    opensc                                        # provides 'pkcs15-tool'
    pam_u2f
    pcsc-tools

    # NixOS-AddOn's
    direnv
    nix-direnv
    nix-index

    # Networking AddOn's
    cifs-utils
    nmap
    samba
    wirelesstools

    # Virtualization
#    docker
#    k3s
#    kubernetes-helm

    # VPN
    openssl
    openvpn
    update-systemd-resolved
    update-resolv-conf

    # <temp for HessenDrive backup>
    davfs2
    # </temp>
  ];

#   environment.variables = {
#     KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
#   };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        # "lpinfo -v" shows the device URI of found printers
        name = "HP_M400dn";
        model = "everywhere";
        # deviceUri = "ipp://HP%20LaserJet%20Pro%20M404-M405%20%5B814EDC%5D%20(USB)._ipp._tcp.local/";
        deviceUri = "ipp://127.0.0.1:60000/ipp/print";
        location = "B123";
      }
    ];
    ensureDefaultPrinter = "HP_M400dn";
  };

  i18n.defaultLocale = "en_US.UTF-8";
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

  # networking.firewall.enable = false;
  # networking.firewall.allowedTCPPorts = [ 6443 ];    # Kubernetes

  networking.hostName = "katjes";

  networking.networkmanager.enable = true;

#   networking.wireless.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.lix;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 90d";
    persistent = true;
    randomizedDelaySec = "3h";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "pynitrokey"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.bash.shellAliases = {
    la = "eza -ahl";
  };

  programs.firefox.enable = true;

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    la = "eza -ahl";
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.u2f = {
    enable = true;
    settings = {
      authfile = "/etc/u2f_mappings";
      cue = true;
      interactive = true;
      pinverification = 1;
    };
  };

  security.rtkit.enable = true;

  services.autorandr.enable = true;

  services.flatpak.enable = true;

#   services.k3s = {
#     enable = false;
#     role = "server";
#     extraFlags = "--write-kubeconfig-mode 644";    # readable by users in the 'wheel' group
#   };

  services.ipp-usb.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.printing.enable = true;

  services.pcscd.enable = true;

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.resolved.enable = true;               # needed by OpenVPN

  services.rpcbind.enable = true;

  services.smartd.enable = true;

  #services.xserver.displayManager.ssdm.enable = true;
  #services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  systemd.services.ensure-printers = {
    after = [ "ipp-usb.service" "cups.service" ];
    requires = [ "ipp-usb.service" ];
  };

  systemd.services.openvpn-dns-link = {
    description = "Link openvpn-update-systemd-resolved to a predictable path";
    script = ''
      mkdir -p /etc/openvpn/scripts
      ln -sf ${pkgs.openvpn}/libexec/update-systemd-resolved /etc/openvpn/scripts/update-systemd-resolved
    '';
    wantedBy = [ "multi-user.target" ];
  };

  time.timeZone = "Europe/Berlin";

  users.users.mstein = {
    isNormalUser = true;
    description = "Marijke Stein";
    extraGroups = [ "docker" "lp" "networkmanager" "vboxusers" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };

  # <temp for HessenDrive backup>
  users.groups.davfs2.gid = 2020;

  users.users.davfs2 = {
    group = "davfs2";
    isNormalUser = true;
    description = "Temporary user for HessenDrive backup";
    extraGroups = [ "docker" "lp" "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };
  # </temp>

  #virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-xapp pkgs.xdg-desktop-portal-gtk ];
}
