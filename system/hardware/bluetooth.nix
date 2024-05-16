{ ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  # Disable bluetooth on startup
  services.tlp.settings.DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
}
