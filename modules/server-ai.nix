{ config, lib, pkgs, ... }:

{
  boot.blacklistedKernelModules = [ "nouveau" ];

#   environment.sessionVariables = [
#     NVD_BACKEND = "direct";
#     OLLAMA_KEEP_ALIVE = "-1";
#     OLLAMA_NUM_PARALLEL = "2";
#   ];

  environment.systemPackages = with pkgs; [
     nvtopPackages.nvidia
     ollama-cuda
     open-webui
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      nvidia-vaapi-driver
      nvtopPackages.nvidia
    ];
  };

#   hardware.nvidia.open = true;

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

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    home = "/mnt/models/ollama";
    host = "127.0.0.1";
    port = 11434;
  };

  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 8080;
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
    };
  };

  services.openssh.settings.AllowTcpForwarding = lib.mkForce "local";

  services.xserver.videoDrivers = [ "nvidia" ];
}
