{ config, lib, pkgs, userSettings, ... }:

let 
  themePath = "../../../themes/${userSettings.theme}/${userSettings.theme}.yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes/${userSettings.theme}/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../themes/${userSettings.theme}/backgroundurl.txt");
  backgroundSha256 = builtins.readFile(./. + "../../../themes/${userSettings.theme}/backgroundsha256.txt");
in
{
  home.file.".currenttheme".text = userSettings.theme;
  stylix.autoEnable = false;
  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + themePath;

  stylix.fonts = {
    monospace = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    serif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    sansSerif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
    sizes = {
      terminal = 18;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
  };

  stylix.targets.kitty.enable = true;
  programs.feh.enable = true;

  home.file.".fehbg-stylix".text = ''
    #!/bin/sh
    feh --no-fehbg --bg-fill ${config.stylix.image};
  '';
  home.file.".fehbg-stylix".executable = true;
  home.file.".swaybg-stylix".text = ''
    #!/bin/sh
    swaybg -m fill -i ${config.stylix.image};
  '';
  home.file.".swaybg-stylix".executable = true;
  home.file.".swayidle-stylix".text = ''
    #!/bin/sh
    swaylock_cmd='swaylock --indicator-radius 200 --screenshots --effect-blur 10x10'
    swayidle -w timeout 300 "$swaylock_cmd --fade-in 0.5 --grace 5" \
                timeout 600 'hyprctl dispatch dpms off' \
                resume 'hyprctl dispatch dpms on' \
                before-sleep "$swaylock_cmd"
  '';
  home.file.".swayidle-stylix".executable = true;
  home.file = {
    ".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ./oomox-current.conf.mustache;
      extension = ".conf";
    };
    ".config/Trolltech.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ./Trolltech.conf.mustache;
      extension = ".conf";
    };
    ".config/kdeglobals".source = config.lib.stylix.colors {
      template = builtins.readFile ./Trolltech.conf.mustache;
      extesion = "";
    };
    ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./qt5ct.conf);
  };
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${config.stylix.image}

    wallpaper = eDP-1,${config.stylix.image}

    wallpaper = HDMI-A-1,${config.stylix.image}

    wallpaper = DP-1,${config.stylix.image}
  '';
  home.packages = with pkgs; [
    qt5ct libsForQt5.breeze-qt5
  ];
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  programs.bash.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
  };
}
