{ config, pkgs, ... }:

{
#   environment.systemPackages = with pkgs; [
#     nvtopPackages.nvidia
#     open-webui
#   ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Run 'nvidia-smi' to check for hardware acceleration
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = true;
    nvidiaSettings = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Use official NixOS CUDA binary cache to save compilation times
  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };

#   services.ollama = {
#     enable = true;
#     package = pkgs.ollama-cuda;
#     home = "/mnt/models/ollama";
#   };
#
#   services.open-webui = {
#     enable = true;
#     host = "127.0.0.1";
#     port = 8080;
#     environment = {
#       OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
#     };
#   };

  services.xserver.videoDrivers = [ "nvidia" ];
}
