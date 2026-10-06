{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bibata-cursors
    cava
    dgop
    dms-shell
    foot
    fprintd
    hyprland
    hyprlock
    hyprpaper
    khal
    kitty
    mako
    matugen
    niri
    quickshell
    rofi
    swaybg
    waybar
    wayland
    wlogout
  ];
}
