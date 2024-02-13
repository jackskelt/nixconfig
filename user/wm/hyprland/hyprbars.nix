{ stdenv, pkgs, hyprland-plugins, ...}:

stdenv.mkDerivation  {
    pname = "hyprbard";
    version = "stable";
    src = "${hyprland-plugins}/hyprbars";
    nativeBuildInputs = [ pkgs.hyprland.nativeBuildInputs ];
    buildInputs = [ pkgs.hyprland pkgs.hyprland.buildInputs ];
}
