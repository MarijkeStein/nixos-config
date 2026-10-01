{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    hyphen
    hyphenDicts.de_DE
    hyphenDicts.de-de
    hyphenDicts.en_US
    hyphenDicts.en-us
    libreoffice
  ];
}
