{ pkgs, ... }:

{
  services.ipp-usb.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cups-filters pkgs.gutenprint ];

  systemd.services.ensure-printers = {
    after = [ "ipp-usb.service" "cups.service" ];
    requires = [ "ipp-usb.service" ];
  };
}
