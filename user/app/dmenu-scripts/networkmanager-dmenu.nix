{ pkgs, dmenu_command ? "rofi -show dmenu", ... }:

{
  home.packages = with pkgs; [ networkmanager_dmenu networkmanagerapplet ];
}
