{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bindfs
    nfs-utils
  ];
}
