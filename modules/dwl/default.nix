{
  pkgs,
  lib,
  config,
  ...
}:

{
  # Enable greetd logon manager
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember remember-session --cmd 'dwl'";
      };
    };
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet # Login manager
    dwl # Window manager
    wmenu # Menu
    wl-clipboard # Copy/paste
    somebar # DWL Bar
    wbg # background
  ];

  fonts = {
    packages = with pkgs; [ nerdfonts ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # screenshare
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      dwl =
        (prev.dwl.overrideAttrs (old: {
          patches = [
            ./bar.patch
            ./gaps.patch
          ];
          buildInputs = old.buildInputs ++ [
            final.fcft
            final.pixman
            final.libdrm
          ];
        })).override
          {
            configH = ./config.h;
          };
    })
  ];
}
