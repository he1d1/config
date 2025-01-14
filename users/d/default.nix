{ pkgs, lib, ... }:
{
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

    matchBlocks = {
      "pi-controller-01" = {
        hostname = "192.168.1.101";
      };
      "pi-controller-02" = {
        hostname = "192.168.1.102";
      };
      "pi-controller-03" = {
        hostname = "192.168.1.103";
      };
    };
  };
}
