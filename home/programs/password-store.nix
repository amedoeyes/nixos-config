{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.password-store;
in
{
  config.programs.password-store = lib.mkIf cfg.enable {
    package = pkgs.pass.withExtensions (
      _: with pkgs.passExtensions; [
        pass-otp
        pass-meta
      ]
    );
    settings = {
      PASSWORD_STORE_DIR = lib.mkIf config.xdg.enable "${config.xdg.dataHome}/password-store";
    };
  };
}
