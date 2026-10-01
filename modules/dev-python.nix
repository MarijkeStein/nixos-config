{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm
    python313
    python313Packages.ipython
    uv
  ];
}
