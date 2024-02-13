{ pkgs, ...}:
let
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    neofetch = "disfetch";
    fetch = "disfetch";
    gitfetch = "onefetch";
    nixos-rebuild = "systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=6000M -p CPUQuota=60% nixos-rebuild";
    home-manager = "systemd-run --no-ask-password --uid=1000 --user --scope -p MemoryLimit=6000M -p CPUQuota=60% home-manager";
  };
in
{
  programs.fish = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = true;
  };

  home.packages = with pkgs; [
    disfetch lolcat cowsay onefetch
    gnugrep gnused
    bat eza bottom fd bc
    direnv nix-direnv
  ];

  programs.direnv.enable = true;
  programs.direnv.enableFishIntegration = true;
}
