{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/base.nix
      ../../modules/desktop-apps.nix
      ../../modules/lang-de.nix
      ../../modules/network-nfs.nix
      ../../modules/network-wifi.nix
      ../../modules/security-fido2.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "nfs" ];

  environment.systemPackages = with pkgs; [
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

#   hardware.printers = {
#     ensurePrinters = [
#       {
#         # "lpinfo -v" shows the device URI of found printers
#         name = "HP_M400dn";
#         model = "everywhere";
#         # deviceUri = "ipp://HP%20LaserJet%20Pro%20M404-M405%20%5B814EDC%5D%20(USB)._ipp._tcp.local/";
#         deviceUri = "ipp://127.0.0.1:60000/ipp/print";
#         location = "B123";
#       }
#     ];
#     ensureDefaultPrinter = "HP_M400dn";
#   };

  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "kitkat";

  networking.networkmanager.enable = true;

  networking.wireless.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.lix;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +10";
#     options = "--delete-older-than 90d";
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

  programs.niri.enable = true;

#  security.pam.services = {
#    login.u2fAuth = true;
#    sudo.u2fAuth = true;
#  };
#
#  security.pam.u2f = {
#    enable = true;
#    settings = {
#      authfile = "/etc/u2f_mappings";
#      cue = true;
#      interactive = true;
#      pinverification = 1;
#    };
#  };

  security.rtkit.enable = true;

#  services.autorandr.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

#  services.flatpak.enable = true;

  services.greetd.enable = true;

#  services.ipp-usb.enable = true;

  services.libinput.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.printing.enable = true;

#  services.pcscd.enable = true;

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

#  services.xserver.enable = true;
#  services.xserver.displayManager.lightdm.enable = true;
#  services.xserver.desktopManager.xfce.enable = true;
#  services.xserver.xkb = {
#    layout = "de";
#    variant = "";
#  };

  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

#  systemd.services.ensure-printers = {
#    after = [ "ipp-usb.service" "cups.service" ];
#    requires = [ "ipp-usb.service" ];
#  };

#  systemd.services.openvpn-dns-link = {
#    description = "Link openvpn-update-systemd-resolved to a predictable path";
#    script = ''
#      mkdir -p /etc/openvpn/scripts
#      ln -sf ${pkgs.openvpn}/libexec/update-systemd-resolved /etc/openvpn/scripts/update-systemd-resolved
#    '';
#    wantedBy = [ "multi-user.target" ];
#  };

  time.timeZone = "Europe/Berlin";

  users.users."marijke" = {
    isNormalUser = true;
    description = "Marijke Stein";
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };


#   virtualisation.virtualbox.host.enable = true;
#   virtualisation.virtualbox.host.enableExtensionPack = true;

#  xdg.portal.enable = true;
#  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-xapp pkgs.xdg-desktop-portal-gtk ];
}
