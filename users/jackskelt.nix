{ pkgs, ... }: 

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jackskelt = {
    isNormalUser = true;
    description = "JackSkelt";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
