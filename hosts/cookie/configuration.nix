{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ../../modules/base.nix
      ../../modules/boot-systemd.nix
      ../../modules/desktop-apps.nix
      ../../modules/desktop-fonts.nix
      ../../modules/desktop-kde.nix
      ../../modules/desktop-latex.nix
      ../../modules/desktop-media.nix
      ../../modules/desktop-office.nix
      ../../modules/dev-generic.nix
      ../../modules/dev-gleam.nix
      ../../modules/dev-python.nix
      ../../modules/lang-de.nix
      ../../modules/mount-of1-pub.nix
      ../../modules/network-nfs.nix
      ../../modules/network-wifi.nix
    ];

  environment.systemPackages = with pkgs; [
  ];

  networking.hostName = "cookie";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.lix;
  };

  programs.firefox.enable = true;

  security.rtkit.enable = true;

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

