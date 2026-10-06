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

  programs.firefox.enable = true;

  programs.thunderbird.enable = true;

  security.rtkit.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.blueman.enable = true;

  services.flatpak.enable = true;

  services.gvfs.enable = true;

  services.libinput.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
#     wireplumber.extraConfig = {
#     "10-bluez" = {
#       "monitor.bluez.properties" = {
#         "bluez5.enable-sbc-xq" = true;
#         "bluez5.enable-msbc" = true;
#         "bluez5.enable-hw-volume" = true;
#         "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" "a2dp_sink" "a2dp_source" ];
#         };
#       };
#     };
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-filters pkgs.gutenprint ];

  services.pulseaudio.enable = false;
}
