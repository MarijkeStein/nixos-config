{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    beam28Packages.erlang
    erlang_28
    gleam
  ];
}
