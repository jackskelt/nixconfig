{ pkgs, ...}:

{
  home.packages = [ pkgs.starship ];

  programs.starship.enable = true;

  # Install starship in kitty
  programs.fish.interactiveShellInit = "starship init fish | source";
}
