{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
     nixosConfigurations = {
       "katjes" = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [ ../configuration.nix
                     ./bluetooth.nix ];
       };
       "nixos" = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [ ../configuration.nix
                     ./bluetooth.nix ];
       };
     };
  };
}
