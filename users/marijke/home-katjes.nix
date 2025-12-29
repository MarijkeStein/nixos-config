{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mstein";
  home.homeDirectory = "/home/mstein";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nix-output-monitor

    pkgs.autorandr
    pkgs.borgbackup
    pkgs.fend
    pkgs.nmap

    pkgs.devilspie2
    pkgs.espanso
    pkgs.xfce.xfconf

    pkgs.libsForQt5.qt5ct
    pkgs.kdePackages.kate
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.konsole
    pkgs.kdePackages.okular
    pkgs.marksman

    pkgs.corefonts
    pkgs.vista-fonts

    pkgs.cdparanoia
    pkgs.flac
    pkgs.vorbis-tools

    #pkgs.fluffychat
    pkgs.nextcloud-client
    pkgs.remmina

    pkgs.gitkraken
    pkgs.jetbrains.pycharm
    pkgs.meld
    pkgs.mesa
    pkgs.python313
    pkgs.python313Packages.ipython
    pkgs.rustup
    pkgs.starship
    pkgs.uv
    pkgs.waveterm

    pkgs.fluffychat


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  nixpkgs.config.permittedInsecurePackages = [
    "fluffychat-linux-1.27.0"
    "olm-3.2.16"
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.ls file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "mcedit";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Marijke Stein";
        email = "marijke.stein@hfmdk-frankfurt.de";
      };
      alias = {
        co = "checkout";
        st = "status";
      };
      core.editor = "mcedit";
      init.defaultBranch = "main";
    };
  };

  home.file.".bashrc" = {
  text = ''
alias la="eza -al --icons --git"

eval "$(starship init bash)"
    '';
  };

  # for NitroKey:
  home.file.".gnupg/scdaemon.conf" = {
  text = ''
disable-ccid
    '';
  };

#  services.udev.extraRules = ''
#    KERNEL=="hidraw*", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="4108", TAG+="uaccess"
#  '';
#
#  # If you want to use GPG/PCSC daemon with it, you might need these as well
#  services.udev.extraRules = ''
#    # Yubico PCSC daemon
#    ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="4108", ENV{ID_SMARTCARD_READER}="1", TAG+="uaccess"
#  '';

  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry.package = pkgs.pinentry-gtk2;

  gtk.enable = true;
  gtk.theme.name = "Adwaita-dark";

  qt.enable = true;
  qt.style.name = "darker";

  xfconf = {
    settings = {
      xfce4-desktop = {
        "backdrop/screen0/monitorDP-2/workspace1/image-style" = 1;
        "backdrop/screen0/monitorDP-2/workspace1/last-image" = "/home/mstein/.wallpapers/HfMDK-black.png";
        "backdrop/screen0/monitorDP-2/workspace1/rgba1" = [ 0.000000 0.000000 0.000000 1.000000 ];
        "desktop-icons/file-icons/show-filesystem" = 0;
        "desktop-icons/file-icons/show-trash" = 1;
      };

      xfce4-notifyd = {
        "mute-sounds" = true;
      };

      xfce4-panel = {
        "panels/dark-mode" = true;

        "panels/panel-1/icon-size" = 16;
        "panels/panel-1/output-name" = "DP-2";
        "panels/panel-1/size" = 30;

        "plugin-1" = "applicationsmenu";

        "plugin-2" = "tasklist";
        "plugin-2/grouping" = 0;

        "plugin-3" = "separator";
        "plugin-3/expand" = true;
        "plugin-3/style" = 0;

        "plugin-4" = "pager";

        "plugin-5" = "separator";

        "plugin-6" = "systray";

        "plugin-7" = "separator";

        "plugin-8" = "clock";
        "plugin-8/digital-date-font" = "Sans 10";
        "plugin-8/timezone" = "Europe/Berlin";

        "plugin-9" = "separator";

        "plugin-10" = "actions";

        "plugin-11" = "power-manager-plugin";

        "plugin-13" = "clock";
        "plugin-13/digital-layout" = 3;
        "plugin-13/digital-time-font" = "Sans 10";
      };

      xfce4-screensaver = {
        "lock/saver-activation/enabled" = false;
        "saver/enabled" = false;
      };

      xsettings = {
        "Gtk/FontName" = "Sans 11.5";
        "MonospaceFontName" = "Gtk/JetBrainsMono Nerd Font 10";
        "Net/IconThemeName" = "Adwaita";
        "Net/ThemeName" = "Adwaita-dark";
      };
    };
  };
}
