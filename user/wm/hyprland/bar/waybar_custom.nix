{ pkgs, userSettings, config, ... }:

let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      postPatch = ''
        # use hyprctl to switch workspaces
        sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprworkspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        sed -i 's/gIPC->getSocket1Reply("dispatch workspace " + std::to_string(id()));/const std::string command = "hyprworkspace " + std::to_string(id());\n\tsystem(command.c_str());/g' src/modules/hyprland/workspaces.cpp
      '';
    });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "7 7 3 7";
        # spacing = 4;
        modules-left = [ "idle_inhibitor" "hyprland/workspaces" "hyprland/window" "mpd" ];
        modules-center = [ "clock" "custom/weather" ];
        modules-right = [ "pulseaudio" "temperature" "cpu" "memory" "battery" "bluetooth" "network" "tray"];

        "hyprland/workspaces" = {
          "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };

        "hyprland/window" = {
          format = "{class} > {title}";
          "rewrite" = {
            "kitty > (.*)" = "🐱 $1";
            "discord > (.*) - Discord" = "󰙯  $1";
            ".* > (.*) - qutebrowser" = "  $1";
            "floorp > (.*) -(.*) Ablaze Floorp" = "  $1";
            "floorp > Ablaze Floorp" = "  New Page";
            "Code > (.*) - .*" = "󰨞  $1";
            "spotify > (.*)" = "  $1";
          };
        };

        clock = {
          format = "{:%a, %d %b, %R}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";  
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "week-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon}󰂯 {format_source}";
          "format-bluetooth-muted" = " {icon}󰂯 {format_source}";
          "format-muted" = "  {format_source}";
          "format-source" = "{volume}%  ";
          "format-source-muted" = " ";
          "format-icons" = {
            headphone = "󰋋 ";
            "hands-free" = "󱀞 ";
            headshet = "󰋋 ";
            phone = " ";
            portable = " ";
            car = "󰄋 ";
            default = [ " " " " " " ];
          };
          "on-click" = "pypr toggle pavucontrol && hyprctl dispatch bringactivetotop";
          "min-length" = 6;
        };
        
        memory = { # Replace with custom memory
          format = "{used:0.1f}GiB ";
          "tooltip-format" = "Swap: {swapUsed:0.1f}/{swapTotal:0.1f} ({swapPercentage}%)\nUsed: {used:0.1f}/{total:0.1f} ({percentage}%)\nAvailable: {avail:0.1f}\nSwap available: {swapAvail:0.1f}";
        };

        temperature = {
          "thermal-zone" = 1;
          "critical-threshold" = 80;
          format = "{temperatureC}°C {icon}";
          "format-icons" = [ "" "" "" "" "" ];  
        };

        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 10;
          };
          bat = "BAT1";
          adapter = "ADP1";
          format = "{capacity}% {icon}";
          "format-charging" = "{capacity}% {icon}";
          "format-plugged" = "{capacity}% 󰂅 ";
          "format-alt" = "{time} {icon}";
          "format-icons" = {
            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            charging = [ "󰢟 " "󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 " ];
          };
        };

        tray = {
          "icon-size" = 16;
          spacing = 5;
        };

        cpu = {
          format = "{usage}% 󰘚 ";
        };

        bluetooth = {
          format = "󰂯";
          "format-disabled" = "󰂲 ";
          "format-on" = "󰂳";
          "format-connected" = "󰂯";
          "tooltip-format-disabled" = "";
          "tooltip-format-on" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "Connections: {num_connections}\n{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-connected-battery" = "{device_alias}\t{device_address} {device_battery_percentage}% ";
          "format-connected-battery" = "{device_battery_percentage}% 󰂯";
        };

        network = {
          format = "{ifname}";
          "format-wifi" = " ";
          "format-ethernet" = "󰈀 ";
          "format-disconnected" = " ";
          "tooltip-format" = "{ifname} via {gwaddr}";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%)\n󰕒 {bandwidthUpBytes}\n󰇚 {bandwidthDownBytes}\n󰩟 {ipaddr}";
          "tooltip-format-ethernet" = "{ifname}\n󰕒 {bandwidthUpBytes}\n󰇚 {bandwidthDownBytes}\n󰩟 {ipaddr}";
          "tooltip-format-disconnected" = "Disconnected";
          "on-click" = "networkmanager_dmenu";
        };

        "idle_inhibitor" = {
          format = "󱄅 ";
        };
        
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: FontAwesome, ${userSettings.font}; 
        min-height: 20px;
      }


      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2
      }

      #workspaces {
        margin-right: 8px;
        border-radius: 10px;
        transition: none;
        background: #${colors.base01};
      }

      #workspaces button {
        transition: none;
        color: #${colors.base03};
        background: transparent;
        padding: 5px;
        font-size: 12px;
      }

      #workspaces button:hover {
        transition: none;
        box-shadow: inherit;
        text-shadow: inherit;
        border-radius: inherit;
        color: #${colors.base08};
        background: #${colors.base02};
      }

      #workspaces button:first-child:hover {
        border-top-left-radius: inherit;
        border-bottom-left-radius: inherit;
        border-top-right-radius: 0;
        border-bottom-right-radius: 0;
      }

      #workspaces button:last-child:hover {
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
        border-top-right-radius: inherit;
        border-bottom-right-radius: inherit;
      }

      #workspaces button:not(:first-child):not(:last-child):hover {
        border-radius: 0;
      }

      #workspaces button.active {
        color: #${colors.base07};
      }

      #clock {
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #window {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        background: #${colors.base01};
        color: #${colors.base05};
      }

      window#waybar.empty #window {
        background-color: transparent;
      }

      #idle_inhibitor {
        padding: 0 16px; 
        border-radius: 10px;
        transition: none;
        background: #${colors.base01};
        color: #${colors.base05};
        margin-right: 8px;
      }

      #idle_inhibitor.activated {
        background: #7AB1DB;
        color: #FFFFFF;
      }

      #pulseaudio {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #network {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #network.disconnected {
        background: #F39C11;
        color: #FFFFFF;
      }

      #cpu {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #bluetooth {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #bluetooth.on {
        background: #007EF4;
        color: #FFFFFF;
      }

      #bluetooth.connected {
        background: #18BB9C;
        color: #FFFFFF;
      }

      #memory {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #temperature {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #temperature.critical {
        background: #E84C3D;
        color: #FFFFFF;
      }

      #battery {
        margin-right: 8px;
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      #battery.charging {
        background: #18BB9C;
        color: #FFFFFF;
      }

      #battery.warning:not(.charging) {
        background: #F39C11;
        color: #FFFFFF;
      }

      #battery.critical:not(.charging) {
        background: #E84C3D;
        color: #FFFFFF;
        animation: blink 0.5s linear infinite alternate;
      }

      #tray {
        padding: 0 16px;
        border-radius: 10px;
        transition: none;
        color: #${colors.base05};
        background: #${colors.base01};
      }

      @keyframes blink {
        to {
          background: #FFFFFF;
          color: #E84C3d;
        }
      }
      
    '';
  };
}
