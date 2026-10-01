{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cdparanoia
    ffmpeg
    flac
    handbrake
    makemkv
    vorbis-tools
  ];
}
