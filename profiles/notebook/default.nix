{ pkgs, systemSettings, userSettings, ... }:

{
  imports =
  [
    ../../system/hardware-configuration.nix # Hardware configuration
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/printing.nix
    ../../system/hardware/power.nix
    ../../system/hardware/pen-tablet.nix
    ../../system/security/doas.nix
    ../../system/security/firewall.nix
    ../../system/security/automount.nix
    ../../system/security/gpg.nix
    ../../system/wm/hyprland.nix # Window Manager
    ../../system/style/stylix.nix
    ../../system/container/docker.nix
    ../../system/games/steam.nix
  ];

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false; # This need to be false in Samsung Book 2 :(
  
  # Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = [];
    uid = 1000;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    helix
    wget
    fish
    git
    home-manager
    lazygit
    lf
    starship
    eza
    bat

    # VPN
    wireguard-tools
    openvpn
  ];

  # I use fish btw
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  system.stateVersion = "23.11";
}
