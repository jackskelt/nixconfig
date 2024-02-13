{ pkgs, ...}:

{
  home.packages = [ pkgs.blueman ];

  services.blueman-applet.enable = true;
}
