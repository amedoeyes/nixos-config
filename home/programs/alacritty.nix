{ lib, config, ... }:
let
  cfg = config.programs.alacritty;
in
{
  options.programs.alacritty = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = lib.mkIf cfg.default {
      TERMINAL = "alacritty";
    };

    programs.alacritty = {
      settings = {
        window = {
          padding = {
            x = 4;
            y = 4;
          };
          dynamic_padding = true;
        };
        font = with config.theme.font; {
          normal = {
            family = name;
            style = "Regular";
          };
          size = size;
        };
        cursor = {
          style = {
            blinking = "On";
          };
          vi_mode_style = {
            shape = "Block";
            blinking = "On";
          };
        };
        mouse = {
          hide_when_typing = true;
        };
        colors = with config.theme.colors; {
          primary = {
            foreground = "#${c10.hex}";
            background = "#${c00.hex}";
            dim_foreground = "#${c10.hex}";
            bright_foreground = "#${c10.hex}";
          };
          cursor = {
            text = "#${c00.hex}";
            cursor = "#${c10.hex}";
          };
          vi_mode_cursor = {
            text = "#${c00.hex}";
            cursor = "#${c10.hex}";
          };
          search = {
            matches = {
              background = "#${c03.hex}";
              foreground = "#${c10.hex}";
            };
            focused_match = {
              background = "#${c03.hex}";
              foreground = "#${c10.hex}";
            };
          };
          hints = {
            start = {
              foreground = "#${c00.hex}";
              background = "#${c10.hex}";
            };
            end = {
              foreground = "#${c00.hex}";
              background = "#${c10.hex}";
            };
          };
          line_indicator = {
            foreground = "#${c10.hex}";
            background = "#${c01.hex}";
          };
          footer_bar = {
            foreground = "#${c10.hex}";
            background = "#${c00.hex}";
          };
          selection = {
            text = "#${c10.hex}";
            background = "#${c02.hex}";
          };
          normal = {
            black = "#${c00.hex}";
            red = "#${c04.hex}";
            green = "#${c06.hex}";
            yellow = "#${c08.hex}";
            blue = "#${c04.hex}";
            magenta = "#${c06.hex}";
            cyan = "#${c08.hex}";
            white = "#${c10.hex}";
          };
          bright = {
            black = "#${c00.hex}";
            red = "#${c04.hex}";
            green = "#${c06.hex}";
            yellow = "#${c08.hex}";
            blue = "#${c04.hex}";
            magenta = "#${c06.hex}";
            cyan = "#${c08.hex}";
            white = "#${c10.hex}";
          };
          dim = {
            black = "#${c00.hex}";
            red = "#${c04.hex}";
            green = "#${c06.hex}";
            yellow = "#${c08.hex}";
            blue = "#${c04.hex}";
            magenta = "#${c06.hex}";
            cyan = "#${c08.hex}";
            white = "#${c10.hex}";
          };
          indexed_colors = lib.mapAttrsToList (index: color: {
            index = lib.toInt index;
            color = "#" + color;
          }) config.theme.ansiColors;
        };
        keyboard.bindings = [
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
  };
}
