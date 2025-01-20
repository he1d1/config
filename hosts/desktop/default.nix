{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/nixvim
    ../../modules/dwl
    ../../modules/1password.nix
    ../../modules/steam.nix
    ../../modules/spicetify.nix
  ];

  # Use the systemd-boot boot loader.
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "desktop"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

  nixpkgs.config.allowUnfree = true;

  # for Nvidia GPU
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    nvidiaSettings = false;
    open = true;
  };

  system.stateVersion = "24.11"; # Don't change this :)

}
