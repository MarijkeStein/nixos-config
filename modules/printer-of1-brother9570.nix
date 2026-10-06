{ pkgs, ... }:

{
  hardware.printers = {
    ensureDefaultPrinter = "Brother9570";
    ensurePrinters = [
      {
        name = "Brother9570";
        description = "Brother MFC-L9570CDW";
        deviceUri = "ipp://192.168.0.100:631/ipp/print";
        model = "everywhere";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
