{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ../../modules/base.nix
      ../../modules/desktop-apps.nix
      ../../modules/desktop-fonts.nix
      ../../modules/desktop-kde.nix
      ../../modules/desktop-office.nix
    ];

  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "nfs" ];

  console.keyMap = "de";

  environment.sessionVariables.NVD_BACKEND = "direct";

  environment.systemPackages = with pkgs; [
    # Burn-in tests
    memtest_vulkan
    memtester
    mprime
  ];

  fileSystems."/pub" = {
    device = "192.168.0.250:/Backup";
    fsType = "nfs";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      nvidia-vaapi-driver
      nvtopPackages.nvidia
    ];
  };

  hardware.nvidia.open = true;

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

  networking.hostName = "hercules";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

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

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  security.rtkit.enable = true;

  services.blueman.enable = true;

  services.flatpak.enable = true;

  services.gvfs.enable = true;

  services.libinput.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-filters pkgs.gutenprint ];

  services.pulseaudio.enable = false;

  services.smartd.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
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
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  users.users.kosi = {
    uid = 2006;
    group = "family";
    isNormalUser = true;
    description = "Konstantin Stein";
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    packages = with pkgs; [
      protonup-qt
      steam-run
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };
}

