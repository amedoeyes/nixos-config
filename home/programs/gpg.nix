{ lib, config, ... }:
let
  cfg = config.programs.gpg;
in
{
  config.programs.gpg = lib.mkIf cfg.enable {
    homedir = lib.mkIf config.xdg.enable "${config.xdg.dataHome}/gnupg";
  };
}
