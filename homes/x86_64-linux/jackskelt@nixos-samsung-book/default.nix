{ pkgs, lib, ...}:

{
  wayland.windowManager.hyprland = {
   # allow home-manager to configure hyprland
   enable = true;   

   settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    
    input = {
      kb_layout = "br";
    };

    exec-once = [
      "bash ~/.config/hypr/start.sh"
    ];

    bind = [
      "$mod, Q, exec, $terminal" # Open terminal
      "$mod, M, exit" # Exit Wayland
      "$mod, S, exec, rofi -show drun -show-icons" # Open App Bar
    ];
   };
  };

  home.stateVersion = "23.11"; # Did you read the comment?
}
