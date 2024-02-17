{ config, pkgs, userSettings, stylix, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  imports = [
    stylix.homeManagerModules.stylix
    ../../user/app/browser/floorp.nix # Default Browser
    ../../user/app/git/git.nix # Git configuration
    ../../user/app/helix/helix.nix # Code editor
    ../../user/app/terminal/kitty.nix # Default terminal
    ../../user/app/terminal/starship.nix # Starship + fish
    ../../user/hardware/bluetooth.nix # Bluetooth
    ../../user/shell/cli-collection.nix # (Un)useful CLI apps
    ../../user/style/stylix.nix # Customization
    ../../user/shell/sh.nix # Fish and bash config
    ../../user/wm/hyprland/hyprland.nix # Window Manager
  ];

  home.packages = with pkgs; [
    # Core
    fish
    kitty
    git
    floorp
    wev

    # Media
    vlc
    ffmpeg
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
}
