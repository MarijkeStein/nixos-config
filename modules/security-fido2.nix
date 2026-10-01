{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ccid
    nitrokey-udev-rules
    opensc                                        # provides 'pkcs15-tool'
    pam_u2f
    pcsc-tools
  ];
}
