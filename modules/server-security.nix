{ ... }:

{
  # Log rejected or dropped incoming packets to the system journal
  networking.firewall.logRefusedConnections = true;

  # Kill processes that have a profile but are running unconfined
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  # Enable Kernel Page-Table Isolation (KPTI) to mitigate Meltdown/Spectre
  security.forcePageTableIsolation = true;

  # Prevent replacing or patching the running kernel image (e.g. via kexec)
  security.protectKernelImage = true;

  # Restrict sudo to members of the wheel group only
  security.sudo.execWheelOnly = true;

  # Enable Kernel auditing + the Linux audit daemon
  security.audit.enable = true;
  security.auditd.enable = true;

  # Ban IPs that repeatedly fail authentication
  services.fail2ban = {
    enable = true;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
      overalljails = true;
    };
    maxretry = 5;
  };

  services.openssh.settings = {
    # Disable SSH agent forwarding to prevent credential pivoting
    AllowAgentForwarding = false;

    # Disable TCP port forwarding through SSH tunnels
    AllowTcpForwarding = false;

    # Restrict to strong authenticated-encryption ciphers only
    Ciphers = [
      "chacha20-poly1305@openssh.com"
      "aes256-gcm@openssh.com"
      "aes128-gcm@openssh.com"
    ];

    # Disconnect after number of unanswered keepalive probes
    ClientAliveCountMax = 2;

    # Send keepalive probes to detect dead connections
    ClientAliveInterval = 300;

    # Restrict to modern, strong key-exchange algorithms
    KexAlgorithms = [
      "curve25519-sha256"
      "curve25519-sha256@libssh.org"
      "diffie-hellman-group16-sha512"
      "diffie-hellman-group18-sha512"
    ];

    # Disconnect unauthenticated sessions
    LoginGraceTime = 30;

#     # Restrict to encrypt-then-MAC message authentication codes
#     Macs = [
#       "hmac-sha2-512-etm@openssh.com"
#       "hmac-sha2-256-etm@openssh.com"
#       "umac-128-etm@openssh.com"
#     ];

    # Max. authentication attempts per connection
    MaxAuthTries = 3;

    # Disable X11 display forwarding
    X11Forwarding = false;
  };

  # Harden the kernel against ASLR bypasses, BPF exploits, IP spoofing, and source routing attacks
  boot.kernel.sysctl = {
    # Kernel exposure
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;

    # ASLR
    "kernel.randomize_va_space" = 2;

    # BPF JIT hardening
    "net.core.bpf_jit_harden" = 2;

    # Filesystem hardening
    "fs.protected_hardlinks" = 1;
    "fs.protected_symlinks" = 1;

    # Network: reverse path filtering
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;

    # Network: disable redirects and source routing
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # Network: SYN flood protection
    "net.ipv4.tcp_syncookies" = 1;

    # Network: ignore broadcast pings
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
  };
}
