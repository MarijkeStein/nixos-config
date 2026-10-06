{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wirelesstools
  ];
}
