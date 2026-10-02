{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    borgbackup
    borgmatic
    bottom
    curl
    direnv
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
    nix-direnv
    nix-index
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
