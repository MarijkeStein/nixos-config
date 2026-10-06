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

  networking.networkmanager.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +10 --delete-older-than 90d";
    persistent = true;
    randomizedDelaySec = "3h";
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    la = "eza -ahl";
  };

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    la = "eza -ahl";
  };
}
