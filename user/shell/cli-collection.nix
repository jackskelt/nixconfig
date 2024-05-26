{ pkgs-unstable, ...}:

{
  home.packages = with pkgs-unstable; [
    disfetch neofetch lolcat cowsay onefetch starfetch
    cava
    gnugrep gnused
    libnotify
    timer
    bat eza fd bottom ripgrep
    rsync
    htop
    hwinfo
    unzip
    brightnessctl
    fzf
    pandoc
    httpie
  ];

  programs.lazygit = {
    enable = true;
    package = pkgs-unstable.lazygit;
    settings = {
      gui.nerdFontsVersion = "3";
    };
  };
}
