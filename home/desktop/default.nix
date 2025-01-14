{
  config,
  pkgs,
  lib,
  ...
}:

{
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    # desktop apps
    firefox # Browser
    vesktop # Discord
  ];
}
