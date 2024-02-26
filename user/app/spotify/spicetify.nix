{ pkgs, spicetify-nix, ... }:

let
  spicepkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    spicetify-nix.homeManagerModule
  ];

  programs.spicetify = {
    enable = true;
    theme = spicepkgs.themes.text;

    enabledExtensions = with spicepkgs.extensions; [
      fullAppDisplay
      fullAlbumDate
      songStats
      showQueueDuration
      # genre
      adblock
    ];
  };
}
