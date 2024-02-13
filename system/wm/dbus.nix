{ pkgs, ... }: 

{
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconfig ];
  };

  programs.dconf = {
    enable = true;
  };
}
