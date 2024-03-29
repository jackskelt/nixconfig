{ pkgs-unstable, ...}:

{
	home.packages = with pkgs-unstable; [
    gobuster # Path discover
		nmap # Port scanner
		nikto # Web server scanner
		whois # Domain lookup
		dig # DNS lookup
		traceroute # Trace route packets
		wireshark # Network traffic analyze
		hashcat # Hash bruteforce
		metasploit # All-in-one
		netcat-gnu # TCP & UDP port listener and scanner
		exiftool # File metadata manipulator
	];
}
