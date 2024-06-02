{ pkgs-unstable, ...}:

{
  programs.starship = {
    enable = true;
    package = pkgs-unstable.starship;
  };

  # Install starship in kitty
  programs.fish.interactiveShellInit = "starship init fish | source";
}
