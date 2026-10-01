{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fira-sans
    fontconfig
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
  ];
}
