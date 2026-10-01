{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    k3s
    kubernetes-helm
  ];

  environment.variables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  networking.firewall.allowedTCPPorts = [ 6443 ];

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--write-kubeconfig-mode 644";    # readable by users in the 'wheel' group
  };
}
