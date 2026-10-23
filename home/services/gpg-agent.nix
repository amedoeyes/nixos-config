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
  config.services.gpg-agent = lib.mkIf cfg.enable {
    pinentry.package = pkgs.pinentry-terminal;
  };
}
