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
    ../../modules/dev-rust.nix
    ../../modules/dev-web.nix
    ../../modules/lang-us.nix
    ../../modules/network-cifs.nix
    ../../modules/network-nfs.nix
    ../../modules/network-vpn.nix
    ../../modules/network-wifi.nix
    ../../modules/nix-flakes.nix
    ../../modules/printer-fra1-hp400.nix
    ../../modules/security-fido2.nix
  ];

  # networking.firewall.enable = false;

  networking.hostName = "katjes";

  nixpkgs.config.permittedInsecurePackages = [
    "pynitrokey"
  ];

  programs.niri.enable = true;

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

  security.pki.certificateFiles = [
    ./hfmdk-eduroam-root.crt
  ];

  services.autorandr.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  services.pcscd.enable = true;

  services.resolved.enable = true;               # needed by OpenVPN

  services.rpcbind.enable = true;

  services.smartd.enable = true;

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
    shell = pkgs.fish;
  };

#   virtualisation.virtualbox.host.enable = true;
#   virtualisation.virtualbox.host.enableExtensionPack = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "*";
  };
}
