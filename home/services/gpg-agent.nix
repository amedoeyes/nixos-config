{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.gpg-agent;
in
{
  options.services.gpg-agent.pam = lib.mkOption {
    type = lib.types.submodule {
      options = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        keys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.gpg-agent = {
      pinentry.package = pkgs.pinentry-tty;
      extraConfig = lib.mkIf cfg.pam.enable "allow-preset-passphrase";
    };

    xdg.configFile."pam-gnupg" = lib.mkIf cfg.pam.enable {
      text = ''
        ${config.programs.gpg.homedir}
        ${builtins.concatStringsSep "\n" cfg.pam.keys}
      '';
    };
  };
}
