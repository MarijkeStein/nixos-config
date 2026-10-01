{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    eza
    fastfetch
    fend
    file
    fish
    git
    gnupg
    helix
    htop
    killall
    mc
    mmv
    nfs-utils
    ox
    pciutils
    smartmontools
    starship
    tree
    unzip
    usbutils
    wget
    zellij
    zip
  ];
}
