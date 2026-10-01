{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ghostscript
    tex-fmt
    texliveFull
  ];
}
