{ lib, config, ... }:
let
  cfg = config.services.mako;
in
{
  config.services.mako = lib.mkIf cfg.enable {
    settings = with config.theme; {
      font = "${font.name} ${toString font.size}";
      background-color = "#${colors.c00.hex}";
      text-color = "#${colors.c10.hex}";
      border-size = 1;
      border-color = "#${colors.c04.hex}";
      progress-color = "#${colors.c01.hex}";
      padding = 10;
      height = 500;
      default-timeout = 5000;
      "app-name=mpris" = {
        format = "<b>%s</b>\\n%b";
        group-by = "app-name";
      };
      "app-name=control" = {
        width = 350;
        format = "<b>%s</b>\\n%b";
        group-by = "app-name";
        anchor = "top-center";
        text-alignment = "center";
      };
      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
