{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (xsane.override { gimpSupport = true; })
  ];
}
