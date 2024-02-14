{ pkgs, lib, ...}:

{
  home.packages = [ pkgs.kitty ];

  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.65";
    shell_integration = "no-sudo";
  };
}
