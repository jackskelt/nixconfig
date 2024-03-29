{ pkgs-unstable, ... }:

{
	home.packages = with pkgs-unstable; [
		rnote
	];
}
