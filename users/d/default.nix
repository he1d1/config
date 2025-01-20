{ pkgs, lib, ... }:
{
  imports = [
    ../../home
  ];

  programs.git = {
    enable = true;

    userName = "he1d1";
    userEmail = "hey@heidi.codes";

    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0no06qCsMxgQuiXknZmxE1ZqA2GzyWJBLhoTvkyAqh";
      };
    };
  };

  programs.bash = {
    enable = true;
  };

  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
}
