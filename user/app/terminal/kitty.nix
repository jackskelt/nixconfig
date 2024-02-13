{ pkgs, ...}:

{
  home.packages = [ pkgs.kitty ];

  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = "0.65";
  };
}
