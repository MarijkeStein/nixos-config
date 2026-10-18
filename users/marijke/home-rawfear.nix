{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/marijke";
  home.username = "marijke";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
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

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "mcedit";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Marijke Stein";
        email = "iniaition@skalacore.de";
      };
      alias = {
        co = "checkout";
        st = "status";
      };
      commit.gpgsign = "false";
      core.editor = "mcedit";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      signing.format = "openpgp";
      signing.signByDefault = false;
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;   # defaults will be removed in future release and get replaced by "*" (see below)
    settings = {
      "github.com" = {
        Hostname = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/Marijke2025-GitHub";
      };
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
}
