{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Inconsolata" ];})
    powerline
    inconsolata
    inconsolata-nerdfonts
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
  ];
}
