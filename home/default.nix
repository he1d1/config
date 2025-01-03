{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "d";
  home.homeDirectory = "/home/d";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’

    # networking tools
    dnsutils # `dig` + `nslookup`
    nmap # A utility for network discovery and security auditing

    # misc
    coreutils
    cowsay
    curl
    findutils
    gnused
    gnupg
    gnugrep
    htop
    moreutils
    mtr
    pstree
    pv
    rename
    rsync
    tree
    wget
    which
    zstd

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    xdg-user-dirs

    # desktop apps
    firefox # Browser
    vesktop # Discord
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      # export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
