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

    bind = [
      "$mod, Q, exec, $terminal"
      "$mod, M, exit"
    ];
   };
  };

  home.stateVersion = "23.11"; # Did you read the comment?
}
