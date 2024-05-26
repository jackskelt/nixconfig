{ pkgs-unstable, ...}:
let
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    cd = "z";
    lg = "lazygit";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
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
    shellAliases = myAliases;
  };

  home.packages = with pkgs-unstable; [
    disfetch lolcat cowsay onefetch
    gnugrep gnused
    bat eza bottom fd bc
  ];

  programs.zoxide = {
    enable = true;
    package = pkgs-unstable.zoxide;
    enableFishIntegration = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
