{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    kdePackages.kate
    kdePackages.kconfig
    kdePackages.kolourpaint
    kdePackages.konsole
    kdePackages.okular
    marksman
  ];
}
