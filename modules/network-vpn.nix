{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssl
    openvpn
    update-resolv-conf
    update-systemd-resolved
  ];
}
