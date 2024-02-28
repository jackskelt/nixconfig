{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Inconsolata" ];})
    powerline
    inconsolata
    inter
    inconsolata-nerdfont
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
  ];
}
