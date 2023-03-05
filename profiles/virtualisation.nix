{ config, ... }: {
  # Virtualisation settings
  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };
}