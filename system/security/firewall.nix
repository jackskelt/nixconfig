{ ... }:

{
  # Firewall
  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    57621 # Spotify sync
  ];
  networking.firewall.allowedUDPPorts = [ 
    5353 # Spotify sync
  ];
}
