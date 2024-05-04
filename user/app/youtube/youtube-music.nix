{ pkgs-unstable, ...}:

{
	home.packages = with pkgs-unstable; [
		youtube-music
	];
}
