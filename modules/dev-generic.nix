{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    claude-code
    claude-monitor
    gcc
    gnumake
    just
    pkg-config
  ];
}
