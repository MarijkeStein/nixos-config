{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Burn-in testing
    memtest_vulkan
    memtester
    mprime

    # Network
    nmap
  ];
}
