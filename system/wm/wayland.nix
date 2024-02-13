{ pkgs, ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = [ pkgs.wayland ];

  services.xserver = {
    enable = true;
    layout = "br";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
