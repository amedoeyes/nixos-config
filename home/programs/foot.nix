{ lib, config, ... }:
let
  cfg = config.programs.foot;
in
{
  options.programs.foot = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = lib.mkIf cfg.default {
      TERMINAL = "foot";
    };

    programs.foot = {
      settings = {
        main = {
          font = with config.theme.font; "${name}:size=${toString size}";
          pad = "4x4 center";
        };
        scrollback = {
          indicator-position = "none";
        };
        cursor = {
          blink = "yes";
          beam-thickness = 0.5;
        };
        mouse = {
          hide-when-typing = "true";
        };
        colors-dark =
          with config.theme.colors;
          {
            background = c00.hex;
            foreground = c10.hex;
            cursor = "${c00.hex} ${c10.hex}";
            regular0 = c00.hex;
            regular1 = c04.hex;
            regular2 = c06.hex;
            regular3 = c08.hex;
            regular4 = c04.hex;
            regular5 = c06.hex;
            regular6 = c08.hex;
            regular7 = c10.hex;
            bright0 = c00.hex;
            bright1 = c04.hex;
            bright2 = c06.hex;
            bright3 = c08.hex;
            bright4 = c04.hex;
            bright5 = c06.hex;
            bright6 = c08.hex;
            bright7 = c10.hex;
            selection-foreground = c10.hex;
            selection-background = c02.hex;
            jump-labels = "${c00.hex} ${c10.hex}";
            search-box-no-match = "${c00.hex} ${c00.hex}";
            search-box-match = "${c10.hex} ${c00.hex}";
          }
          // config.theme.ansiColors;
        key-bindings = {
          search-start = "Control+Shift+slash";
        };
        search-bindings = {
          find-prev = "Control+N";
          find-next = "Control+n";
        };
      };
    };
  };
}
