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
		thc-hydra # Log-on cracker
		ncftp # FTP (wtf nix doesn't already have one)
		binwalk # Find embedded file in image
		john # John The Ripper - Password Cracker
		steghide # Steganography tool
		sherlock # Social Media lookup
		holehe # Check mail usage
	];
}
