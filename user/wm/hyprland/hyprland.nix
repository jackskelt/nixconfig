{ config, lib, pkgs, userSettings, systemSettings, ...}:

{
  imports = [
    ../../app/terminal/kitty.nix
    (import ../../app/dmenu-scripts/networkmanager-dmenu.nix {
      dmenu_command = "fuzzel -d"; inherit config lib pkgs;
    })
    ./bar/waybar.nix
    ./screen_locker/swaylock.nix
    ./app_launcher/fuzzel.nix
    ./app_launcher/fuzzmoji/fuzzmoji.nix
    ./notification/fnott.nix
  ];

  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
    size = 36;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ ];
    settings = { };
    extraConfig = ''
      exec-once = dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}

      exec-once = pypr
      exec-once = nm-applet
      exec-once = blueman-applet
      exec-once = waybar

      exec-once = swayidle -w timeout 90 '${config.programs.swaylock.package}/bin/swaylock -f' timeout 120 'suspend-unless-render' resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' before-sleep "${config.programs.swaylock.package}/bin/swaylock -f"

      exec = ~/.swaybg-stylix

      general {
        layout = master
        cursor_inactive_timeout = 30
        border_size = 4
        no_cursor_warps = false
        col.active_border = 0xff${config.lib.stylix.colors.base08}
        col.inactive_border = 0x33${config.lib.stylix.colors.base08}
        resize_on_border = true
        gaps_in = 7
        gaps_out = 7
      }

      plugin {
        hyprbars {
          bar_height = 0
          bar_color = 0xee${config.lib.stylix.colors.base00}
          col.text = 0xff${config.lib.stylix.colors.base05}
          bar_text_font = ${userSettings.font}
          bar_text_size = 12
          buttons {
            button_size = 0
            col.maximize = 0xff${config.lib.stylix.colors.base0A}
            col.close = 0xff${config.lib.stylix.colors.base08}
          }
        }
      }
      
        # Window alternator
        bind=SUPER,SPACE,fullscreen,1
        bind=ALT,TAB,cyclenext
        bind=ALT,TAB,bringactivetotop
        bind=ALTSHIFT,TAB,cyclenext,prev
        bind=ALTSHIFT,TAB,bringactivetotop
        bind=SUPER,Y,workspaceopt,allfloat

        # Create terminal
        bind=SUPER,RETURN,exec,${userSettings.term}

        # Create terminal with editor
        bind=SUPER,A,exec,${userSettings.spawnEditor}

        # Create browser
        bind=SUPER,S,exec,${userSettings.browser}        

        # Kill waybar
        bind=SUPERCTRL,R,exec,killall .waybar-wrapped && waybar & disown

        # Init fuzzel 
        bind=SUPER,SPACE,exec,fuzzel

        # Dismiss notification
        bind=SUPER,X,exec,fnottctl dismiss
        bind=SUPERSHIFT,X,exec,fnottctl dismiss all

        # Kill active window process
        bind=SUPER,Q,killactive

        # Ragequit
        bind=SUPERSHIFT,Q,exit        

        # Window move
        bindm=SUPER,mouse:272,movewindow # Left click
        bindm=SUPER,mouse:273,resizewindow # Right click

        bind=SUPER,T,togglefloating

        # Screenshot
        bind=,code:107,exec,grim -g "$(slurp)" - | wl-copy
        bind=SHIFT,code:107,exec,grim -g "$(slurp -o)" - | wl-copy
        bind=SUPER,code:107,exec,grim - | wl-copy
        bind=CTRL,code:107,exec,grim -g "$(slurp)"
        bind=SHIFTCTRL,code:107,exec,grim -g "$(slurp -o)"
        bind=SUPERCTRL,code:107,exec,grim

        # Volume
        bind=,code:122,exec,pamixer -d 10
        bind=,code:123,exec,pamixer -i 10
        bind=,code:121,exec,pamixer -t
        bind=SHIFT,code:121,exec,pamixer --default-source -t
        bind=SHIFT,code:122,exec,pamixer --default-source -d 10
        bind=SHIFT,code:123,exec,pamixer --default-source -i 10

        # Brightness
        bind=,code:233,exec,brightnessctl set +15%
        bind=,code:232,exec,brightnessctl set 15%-

        # Color picker
        bind=SUPER,C,exec,wl-copy $(hyprpicker)

        # Emoji picker
        bind=SUPER,code:60,exec,fuzzmoji

        # Suspend
        # bind=,STANDBY,exec,swaylock --grace 0
        # bind=SUPER,STANDBY,exec,swaylock --grace 0 & sleep 1 && systemctl suspend

        # Window focus
        bind=SUPER,H,movefocus,l
        bind=SUPER,J,movefocus,d
        bind=SUPER,K,movefocus,u
        bind=SUPER,L,movefocus,r

        # Move window
        bind=SUPERSHIFT,H,movewindow,l
        bind=SUPERSHIFT,J,movewindow,d
        bind=SUPERSHIFT,K,movewindow,u
        bind=SUPERSHIFT,L,movewindow,r

        # Change workspace
        bind=SUPER,1,exec,hyprworkspace 1
        bind=SUPER,2,exec,hyprworkspace 2
        bind=SUPER,3,exec,hyprworkspace 3
        bind=SUPER,4,exec,hyprworkspace 4
        bind=SUPER,5,exec,hyprworkspace 5
        bind=SUPER,6,exec,hyprworkspace 6
        bind=SUPER,7,exec,hyprworkspace 7
        bind=SUPER,8,exec,hyprworkspace 8
        bind=SUPER,9,exec,hyprworkspace 9

        # Move window to workspace
        bind=SUPERSHIFT,1,movetoworkspace,1
        bind=SUPERSHIFT,2,movetoworkspace,2
        bind=SUPERSHIFT,3,movetoworkspace,3
        bind=SUPERSHIFT,4,movetoworkspace,4
        bind=SUPERSHIFT,5,movetoworkspace,5
        bind=SUPERSHIFT,6,movetoworkspace,6
        bind=SUPERSHIFT,7,movetoworkspace,7
        bind=SUPERSHIFT,8,movetoworkspace,8
        bind=SUPERSHIFT,9,movetoworkspace,9

        # Pypr utils
        bind=SUPER,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop
        bind=SUPER,N,exec,pypr toggle musikcube && hyprctl dispatch bringactivetotop
        bind=SUPER,B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop
        bind=SUPER,E,exec,pypr toggle geary && hyprctl dispatch bringactivetotop
        bind=SUPER,P,exec,pypr toggle pavucontrol && hyprctl dispatch bringactivetotop

        # Opacities and window customization 
        
        $scratchpadsize = size 80% 85%

        $scratchpad = class:^(scratchpad)$
        windowrulev2 = float,$scratchpad
        windowrulev2 = $scratchpadsize,$scratchpad
        windowrulev2 = workspace special silent,$scratchpad
        windowrulev2 = center,$scratchpad

        $gearyscratchpad = class:^(geary)$
        windowrulev2 = float,$gearyscratchpad
        windowrulev2 = $scratchpadsize,$gearyscratchpad
        windowrulev2 = workspace special silent,$gearyscratchpad
        windowrulev2 = center,$gearyscratchpad

        $pavucontrol = class:^(pavucontrol)$
        windowrulev2 = float,$pavucontrol
        windowrulev2 = size 86% 40%,$pavucontrol
        windowrulev2 = move 50% 6%,$pavucontrol
        windowrulev2 = workspace special silent,$pavucontrol
        windowrulev2 = opacity 0.8,$pavucontrol

        layerrule = blur,waybar

        # Zoom
        bind=SUPER,backslash,exec,pypr zoom
        bind=SUPER,backslash,exec,hyprctl reload

        # Change workspace
        bind=SUPERCTRL,right,workspace,+1
        bind=SUPERCTRL,left,workspace,-1

        # Utils
        bind=SUPER,I,exec,networkmanager_dmenu
        bind=SUPERSHIFT,P,exec,hyprprofile-dmenu


        # Monitors/Screens
        monitor=eDP-1,1920x1080,0x0,1

      

        xwayland {
          force_zero_scaling = true
        }

        env = QT_QPA_PLATFORMTHEME,qt5ct

        input {
          kb_layout = br
          kb_options = caps:escape
          repeat_delay = 350
          repeat_rate = 30
          accel_profile = adaptive
          follow_mouse = 2

          touchpad {
            natural_scroll = true
          }
        }

        gestures {
          workspace_swipe = true;
        }

        misc {
          mouse_move_enables_dpms = false
          disable_hyprland_logo = true
        }
      
        decoration {
          rounding = 8
          blur {
            enabled = true
            size = 5
            passes = 2
            ignore_opacity = true
            contrast = 1.17
          }
        }
    '';
    xwayland = { enable = true; };
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    kitty
    feh
    killall
    polkit_gnome
    libva-utils
    gsettings-desktop-schemas
    gnome.zenity
    wlr-randr
    wtype
    ydotool
    wl-clipboard
    hyprland-protocols
    hyprpicker
    swayidle
    swaybg
    fnott
    fuzzel
    pinentry-gnome
    wev
    grim
    slurp
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    wlsunset
    pavucontrol
    pamixer
    (pkgs.writeScriptBin "sct" ''
      #!/bin/sh
      killall wlsunset &> /dev/null;
      if [ $# -eq 1 ]; then
        temphigh=$(( $1 + 1 ))
        templow=$1
        wlsunset -t $templow -T $temphigh &> /dev/null &
      else
        killall wlsunset &> /dev/null;
      fi
    '')
    (pkgs.writeScriptBin "suspend-unless-render" ''
      #!/bin/sh
      if pgrep -x nixos-rebuild > /dev/null || pgrep -x home-manager > /dev/null || pgrep -x kdenlive > /dev/null || pgrep -x FL64.exe > /dev/null || pgrep -x blender > /dev/null || pgrep -x flatpak > /dev/null;
      then echo "Shouldn't suspend"; sleep 10; else echo "Should suspend"; systemctl suspend; fi
    '')
    (pkgs.writeScriptBin "hyprworkspace" ''
      #!/bin/sh
      # from https://github.com/taylor85345/hyprland-dotfiles/blob/master/hypr/scripts/workspace
      monitors=/tmp/hypr/monitors_temp
      hyprctl monitors > $monitors

      if [[ -z $1 ]]; then
        workspace=$(grep -B 5 "focused: no" "$monitors" | awk 'NR==1 {print $3}')
      else
        workspace=$1
      fi

      activemonitor=$(grep -B 11 "focused: yes" "$monitors" | awk 'NR==1 {print $2}')
      passivemonitor=$(grep  -B 6 "($workspace)" "$monitors" | awk 'NR==1 {print $2}')
      #activews=$(grep -A 2 "$activemonitor" "$monitors" | awk 'NR==3 {print $1}' RS='(' FS=')')
      passivews=$(grep -A 6 "Monitor $passivemonitor" "$monitors" | awk 'NR==4 {print $1}' RS='(' FS=')')

      if [[ $workspace -eq $passivews ]] && [[ $activemonitor != "$passivemonitor" ]]; then
       hyprctl dispatch workspace "$workspace" && hyprctl dispatch swapactiveworkspaces "$activemonitor" "$passivemonitor" && hyprctl dispatch workspace "$workspace"
        echo $activemonitor $passivemonitor
      else
        hyprctl dispatch moveworkspacetomonitor "$workspace $activemonitor" && hyprctl dispatch workspace "$workspace"
      fi

      exit 0

    '')
    (pkgs.python3Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "1.4.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-JRxUn4uibkl9tyOe68YuHuJKwtJS//Pmi16el5gL9n8=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.poetry-core
        poetry
      ];
      doCheck = false;
    })
  ];
  home.file.".config/hypr/pyprland.json".text = ''
    {
      "pyprland": {
        "plugins": ["scratchpads", "magnify"]
      },
      "scratchpads": {
        "term": {
          "command": "kitty --class scratchpad",
          "margin": 50
        },
        "musikcube": {
          "command": "kitty --class scratchpad -e musikcube",
          "margin": 50
        },
        "btm": {
          "command": "kitty --class scratchpad -e btm",
          "margin": 50
        },
        "geary": {
          "command": "geary",
          "margin": 50
        },
        "pavucontrol": {
          "command": "pavucontrol",
          "margin": 50,
          "unfocus": "hide",
          "animation": "fromTop"
        }
      }
    }
  '';
}
