{ pkgs, ...}:

{
  home.packages = with pkgs; [
    disfetch neofetch lolcat cowsay onefetch starfetch
    cava
    gnugrep gnused
    killall
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
    lazygit
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      gui.nerdFontsVersion = "3";
    };
  };
}
