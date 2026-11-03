{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    claude-code
    claude-monitor
    gcc
    gitui
    gnumake
    just
    pkg-config
  ];
}
