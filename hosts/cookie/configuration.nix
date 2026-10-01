{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ../../modules/base.nix
      ../../modules/desktop-apps.nix
      ../../modules/desktop-kde.nix
      ../../modules/backup.nix
      ../../modules/desktop-office.nix
      ../../modules/desktop-latex.nix
      ../../modules/desktop-fonts.nix
      ../../modules/dev-generic.nix
      ../../modules/dev-python.nix
      ../../modules/desktop-media.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "nfs" ];

  console.keyMap = "de";

  environment.systemPackages = with pkgs; [
    # Gleam/Erlang dev
    beam28Packages.erlang
    erlang_28
    gleam

    # Python dev
    jetbrains.pycharm
    python313
    python313Packages.ipython
    uv

#     # Hexaglot dev
#     jetbrains.idea

    # Networking AddOn's
    nmap
    wirelesstools
  ];

  fileSystems."/pub" = {
    device = "192.168.0.250:/Backup";
    fsType = "nfs";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
    };
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

  networking.hostName = "cookie";
  networking.networkmanager.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.lix;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
#     options = "--delete-generations +10";
    options = "--delete-older-than 90d";
    persistent = true;
    randomizedDelaySec = "3h";
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash.shellAliases = {
    la = "eza -ahl";
  };

  programs.firefox.enable = true;

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    la = "eza -ahl";
  };

  security.rtkit.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.blueman.enable = true;

  services.flatpak.enable = true;

  services.gvfs.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.extraConfig = {
    "10-bluez" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" "a2dp_sink" "a2dp_source" ];
        };
      };
    };
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-filters pkgs.gutenprint ];

  services.pulseaudio.enable = false;

  services.smartd.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

#  # Do not auto-update mobile devices as this may significantly slow down the boot process if on slow network
#
#  system.autoUpgrade = {
#    enable = true;
#    allowReboot = false;
#    dates = "daily";
#    randomizedDelaySec = "30min";
#  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  time.timeZone = "Europe/Berlin";

  users.groups.family.gid = 2020;

  users.users.bieni = {
    uid = 1980;
    group = "family";
    isNormalUser = true;
    description = "Sabine Stein";
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.users.caro = {
    uid = 2008;
    group = "family";
    isNormalUser = true;
    description = "Carolin Stein";
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.users.marijke = {
    uid = 2020;
    group = "family";
    isNormalUser = true;
    description = "Marijke Stein";
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };
}

