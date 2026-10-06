{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/boot-grub.nix
    ../../modules/desktop-apps.nix
    ../../modules/desktop-fonts.nix
    ../../modules/desktop-kde.nix
    ../../modules/desktop-latex.nix
    ../../modules/desktop-media.nix
    ../../modules/desktop-office.nix
    ../../modules/desktop-scanner.nix
    ../../modules/dev-generic.nix
    ../../modules/lang-de.nix
    ../../modules/mount-of1-pub.nix
    ../../modules/network-nfs.nix
    ../../modules/nix-flakes.nix
  ];

  boot.kernelModules = [ "sg" ];

  fileSystems."/mnt/scratch" = {
    device = "/dev/sdb2";
    fsType = "ext4";
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  networking.hostName = "venus";

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
    shell = pkgs.fish;
    packages = with pkgs; [
      makemkv
    ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-xapp pkgs.xdg-desktop-portal-gtk ];
}

