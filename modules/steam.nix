{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    steamtinkerlaunch
    mono
    protontricks
  ];
}
