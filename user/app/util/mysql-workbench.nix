{ pkgs, ...}:

{
	home.packages = with pkgs; [
		mysql-workbench
	];
}
