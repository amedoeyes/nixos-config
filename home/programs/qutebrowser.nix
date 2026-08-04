{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.qutebrowser;
in
{
  options.programs.qutebrowser = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home = lib.mkIf cfg.default {
      sessionVariables = {
        BROWSER = "qutebrowser";
      };
    };

    programs.qutebrowser = {
      greasemonkey = [
        (pkgs.fetchurl {
          url = "https://update.greasyfork.org/scripts/9165/Auto%20Close%20YouTube%20Ads.user.js";
          sha256 = "sha256-/SypoUVSVxvUq01s5i5Ep6WhIjCm5Of7JG9m3QSmWXc=";
        })
      ];
      settings = with config.theme; {
        downloads.location.directory = config.xdg.userDirs.download;
        spellcheck.languages = [ "en-US" ];
        tabs.show = "multiple";
        content = {
          blocking = {
            method = "both";
            adblock.lists = [
              "https://easylist.to/easylist/easylist.txt"
              "https://easylist.to/easylist/easyprivacy.txt"
              "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
              "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
              "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
            ];
          };
          prefers_reduced_motion = true;
          user_stylesheets =
            let
              stylesheet =
                pkgs.writeText "qutebrowser-stylesheet.css"
                  # css
                  ''
                    * {
                      font-family: monospace !important;
                      border-radius: 0 !important;
                    }
                  '';
            in
            [
              "${stylesheet}"
            ];
        };
        auto_save.session = true;
        fonts = with font; {
          default_family = name;
          default_size = "${toString size}pt";
        };
        editor.command = [
          config.home.sessionVariables.TERMINAL
          config.home.sessionVariables.EDITOR
          "{}"
        ];
        hints.border = "1px solid #${colors.c04.hex}";
        prompt.radius = 0;
        colors = with colors; {
          completion.fg = "#${c10.hex}";
          completion.even.bg = "#${c00.hex}";
          completion.odd.bg = "#${c00.hex}";
          completion.match.fg = "#${c10.hex}";
          completion.scrollbar.bg = "#${c01.hex}";
          completion.scrollbar.fg = "#${c03.hex}";
          completion.category.bg = "#${c00.hex}";
          completion.category.border.bottom = "#${c04.hex}";
          completion.category.border.top = "#${c04.hex}";
          completion.category.fg = "#${c10.hex}";
          completion.item.selected.bg = "#${c01.hex}";
          completion.item.selected.border.bottom = "#${c00.hex}";
          completion.item.selected.border.top = "#${c00.hex}";
          completion.item.selected.fg = "#${c10.hex}";
          completion.item.selected.match.fg = "#${c10.hex}";
          downloads.bar.bg = "#${c00.hex}";
          downloads.error.bg = "#${c00.hex}";
          downloads.start.bg = "#${c00.hex}";
          downloads.stop.bg = "#${c00.hex}";
          downloads.error.fg = "#${c10.hex}";
          downloads.start.fg = "#${c10.hex}";
          downloads.stop.fg = "#${c10.hex}";
          downloads.system.fg = "none";
          downloads.system.bg = "none";
          hints.bg = "#${c00.hex}";
          hints.fg = "#${c10.hex}";
          hints.match.fg = "#${c04.hex}";
          keyhint.bg = "#${c00.hex}";
          keyhint.fg = "#${c10.hex}";
          keyhint.suffix.fg = "#${c10.hex}";
          messages.error.fg = "#${c10.hex}";
          messages.error.bg = "#${c00.hex}";
          messages.error.border = "#${c00.hex}";
          messages.info.fg = "#${c10.hex}";
          messages.info.bg = "#${c00.hex}";
          messages.info.border = "#${c00.hex}";
          messages.warning.fg = "#${c10.hex}";
          messages.warning.bg = "#${c00.hex}";
          messages.warning.border = "#${c00.hex}";
          prompts.fg = "#${c10.hex}";
          prompts.bg = "#${c00.hex}";
          prompts.border = "1px solid #${c04.hex}";
          prompts.selected.fg = "#${c10.hex}";
          prompts.selected.bg = "#${c01.hex}";
          statusbar.normal.fg = "#${c10.hex}";
          statusbar.normal.bg = "#${c00.hex}";
          statusbar.insert.fg = "#${c10.hex}";
          statusbar.insert.bg = "#${c00.hex}";
          statusbar.command.fg = "#${c10.hex}";
          statusbar.command.bg = "#${c00.hex}";
          statusbar.passthrough.fg = "#${c10.hex}";
          statusbar.passthrough.bg = "#${c00.hex}";
          statusbar.progress.bg = "#${c10.hex}";
          statusbar.private.fg = "#${c10.hex}";
          statusbar.private.bg = "#${c00.hex}";
          statusbar.command.private.fg = "#${c10.hex}";
          statusbar.command.private.bg = "#${c00.hex}";
          statusbar.caret.fg = "#${c10.hex}";
          statusbar.caret.bg = "#${c00.hex}";
          statusbar.caret.selection.fg = "#${c10.hex}";
          statusbar.caret.selection.bg = "#${c00.hex}";
          statusbar.url.fg = "#${c10.hex}";
          statusbar.url.error.fg = "#${c10.hex}";
          statusbar.url.hover.fg = "#${c10.hex}";
          statusbar.url.success.http.fg = "#${c10.hex}";
          statusbar.url.success.https.fg = "#${c10.hex}";
          statusbar.url.warn.fg = "#${c10.hex}";
          tabs.bar.bg = "#${c00.hex}";
          tabs.even.fg = "#${c06.hex}";
          tabs.even.bg = "#${c00.hex}";
          tabs.odd.fg = "#${c06.hex}";
          tabs.odd.bg = "#${c00.hex}";
          tabs.selected.even.fg = "#${c10.hex}";
          tabs.selected.even.bg = "#${c00.hex}";
          tabs.selected.odd.fg = "#${c10.hex}";
          tabs.selected.odd.bg = "#${c00.hex}";
          tabs.pinned.even.fg = "#${c06.hex}";
          tabs.pinned.even.bg = "#${c00.hex}";
          tabs.pinned.odd.fg = "#${c06.hex}";
          tabs.pinned.odd.bg = "#${c00.hex}";
          tabs.pinned.selected.even.fg = "#${c10.hex}";
          tabs.pinned.selected.even.bg = "#${c00.hex}";
          tabs.pinned.selected.odd.fg = "#${c10.hex}";
          tabs.pinned.selected.odd.bg = "#${c00.hex}";
          tabs.indicator.start = "#${c06.hex}";
          tabs.indicator.stop = "#${c10.hex}";
          tabs.indicator.error = "#${c04.hex}";
          tabs.indicator.system = "none";
          contextmenu.menu.fg = "#${c10.hex}";
          contextmenu.menu.bg = "#${c00.hex}";
          contextmenu.disabled.fg = "#${c04.hex}";
          contextmenu.disabled.bg = "#${c00.hex}";
          contextmenu.selected.fg = "#${c10.hex}";
          contextmenu.selected.bg = "#${c00.hex}";
          webpage.preferred_color_scheme = palette;
        };
      };
      keyBindings = {
        command = {
          "<Ctrl-e>" = "cmd-edit";
        };
      };
    };
  };
}
