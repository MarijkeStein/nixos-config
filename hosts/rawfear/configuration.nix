{ config, pkgs, ... }:

{
  imports = [
    ../../modules/base.nix
    ../../modules/boot-systemd.nix
    ../../modules/lang-de.nix
    ../../modules/nix-flakes.nix
    ../../modules/server-ai.nix
    ../../modules/server-security.nix
  ];

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      22
    ];

    allowedUDPPorts = [];

    allowPing = true;
  };

  networking.hostName = "de-fsn01-rawfear";

  nix.settings.trusted-users = [ "root" "marijke" ];

  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "marijke" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.smartd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  time.timeZone = "Europe/Berlin";

  users.groups.ai.gid = 2026;

  users.mutableUsers = true; # Users can change their password

  users.users.marijke = {
    description = "Marijke Stein";
    uid = 2020;
    group = "ai";
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$6$K.VzaEaMT228tBA5$Di5OoWQzUNTHDnE2IPNj7n6AyzeqIEeRI3p9NFpKjxsnTKwg7uyDPFfxR3uio/fCU25D0wb0xOymti5jWvU3B1";  # temporary only, save your time to brute-force it :)
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFG3K8Qyjl/UMT+nimrNw6tHg/3285xi0KEUI0iGDdpw marijke@venus"
    ];
    packages = with pkgs; [
    ];
    shell = pkgs.fish;
  };

  users.users.root = {
    hashedPassword = "!"; # Login disabled
  };
}
