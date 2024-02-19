{ pkgs, userSettings, ...}:

{
  virtualisation.docker.enable = true;

  users.users.${userSettings.username}.extraGroups = [ "docker" ];

  # btrfs
  # virtualisation.docker.storageDriver = "btrfs";
}
