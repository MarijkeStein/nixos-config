{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    blueman
    bluez
    eog
    espanso
    evince
    fluffychat
    gimp
    gnome-terminal
    gnomeExtensions.bluetooth-battery-meter
    gparted
    imagemagick
    keepassxc
    libinput
    libwebp
    mate-calc
    mediainfo
    meld
    mtpfs
    pinentry-gtk2
    pipewire
    pulseaudio
    system-config-printer
    thunar-volman
    thunderbird
    totem
    usbimager
    v4l-utils
    vlc
    xdg-desktop-portal-gtk              # e.g. Gtk FileChooser used by various tools
    xfce4-screensaver
    xfconf
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
#     settings = {
#       General = {
#         Experimental = true;
#         Enable = "Source,Sink,Media,Socket";
#       };
#     };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.blueman.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-filters pkgs.gutenprint ];
}
