{ pkgs, ... }:

{
  boot.supportedFilesystems = [ "nfs" ];

  environment.systemPackages = with pkgs; [
    bindfs
    nfs-utils
  ];
}
