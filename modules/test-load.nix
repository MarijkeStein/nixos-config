{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    memtest_vulkan
    memtester
    mprime
  ];
}
