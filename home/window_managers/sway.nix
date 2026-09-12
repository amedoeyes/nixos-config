{
  pkgs,
  lib,
  config,
  monitors,
  ...
}:
let
  cfg = config.wayland.windowManager.sway;
in
{
  config = lib.mkIf cfg.enable {
    home.pointerCursor.sway.enable = true;

    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config.common = {
        default = "gtk";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      };
    };

    wayland.windowManager.sway = {
      config =
        let
          modifier = cfg.config.modifier;
          scripts = import ./scripts pkgs;
        in
        with config.theme;
        {
          modifier = "Mod4";
          input = {
            "type:keyboard" = {
              xkb_layout = "us,ara";
              xkb_options = "grp:alts_toggle,caps:escape";
            };
            "type:touchpad" = {
              events = "disabled";
            };
            "2:10:TPPS/2_IBM_TrackPoint" = {
              accel_profile = "flat";
              pointer_accel = "0.5";
            };
          };
          output = {
            "*" = {
              background = "#${colors.c00.hex} solid_color";
            };
          }
          // lib.foldl' (
            acc: mon:
            acc
            // {
              "${mon.name}" = {
                resolution = lib.mkIf (
                  mon.resolution != null
                ) "${toString mon.resolution.width}x${toString mon.resolution.height}";
                position = lib.mkIf (mon.position != null) "${toString mon.position.x} ${toString mon.position.y}";
              };
            }
          ) { } monitors;
          workspaceOutputAssign =
            let
              workspacesLen = 10;
              monitorsLen = builtins.length monitors;
              groupSize = builtins.div (workspacesLen + monitorsLen - 1) monitorsLen;
            in
            if monitorsLen > 0 then
              lib.range 1 workspacesLen
              |> map (x: {
                workspace = toString x;
                output = (builtins.elemAt monitors (builtins.div (x - 1) groupSize)).name;
              })
            else
              [ ];
          focus = {
            mouseWarping = "container";
          };
          bars = [ ];
          fonts = with font; {
            names = [ name ];
            size = size * 1.0;
          };
          window = {
            titlebar = false;
            border = 1;
            commands = [
              {
                criteria.app_id = "fzfmenu";
                command = "floating enable";
              }
              {
                criteria.app_id = "fzfmenu";
                command = "focus";
              }
              {
                criteria.app_id = "filepicker";
                command = "floating enable";
              }
              {
                criteria.app_id = "filepicker";
                command = "focus";
              }
            ];
          };
          floating = {
            titlebar = false;
            border = 1;
          };
          gaps = {
            inner = 10;
          };
          keybindings = {
            "${modifier}+return" = "exec ${lib.getExe pkgs.${config.home.sessionVariables.TERMINAL}}";
            "${modifier}+space" = "exec ${lib.getExe scripts.launcher}";
            "${modifier}+c" = "exec ${lib.getExe scripts.clipboard}";
            "${modifier}+p" = "exec ${lib.getExe scripts.password}";
            "${modifier}+o" = "exec ${lib.getExe scripts.otp}";
            "print" = "exec ${lib.getExe pkgs.screenshot}";
            "shift+print" =
              "exec ${lib.getExe pkgs.screenshot} -g \"$(${lib.getExe pkgs.slurp} -b '#${colors.c00.hex}A0' -c '#${colors.c10.hex}FF' -s '#${colors.c00.hex}00' -B '#${colors.c00.hex}A0' -w 1 -o)\"";

            "${modifier}+q" = "kill";

            "${modifier}+f" = "fullscreen";
            "${modifier}+shift+space" = "floating toggle";

            "${modifier}+shift+y" = "move scratchpad";
            "${modifier}+y" = "scratchpad show";

            "${modifier}+t" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+v" = "splith";
            "${modifier}+s" = "splitv";

            "${modifier}+ctrl+space" = "focus mode_toggle";
            "${modifier}+a" = "focus parent";
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";

            "${modifier}+shift+h" = "move left";
            "${modifier}+shift+j" = "move down";
            "${modifier}+shift+k" = "move up";
            "${modifier}+shift+l" = "move right";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+shift+1" = "move container to workspace number 1";
            "${modifier}+shift+2" = "move container to workspace number 2";
            "${modifier}+shift+3" = "move container to workspace number 3";
            "${modifier}+shift+4" = "move container to workspace number 4";
            "${modifier}+shift+5" = "move container to workspace number 5";
            "${modifier}+shift+6" = "move container to workspace number 6";
            "${modifier}+shift+7" = "move container to workspace number 7";
            "${modifier}+shift+8" = "move container to workspace number 8";
            "${modifier}+shift+9" = "move container to workspace number 9";
            "${modifier}+shift+0" = "move container to workspace number 10";

            "${modifier}+r" = "mode RESIZE";
            "${modifier}+m" = "mode MPRIS";
            "${modifier}+n" = "mode NOTIFICATION";

            "XF86AudioMute" = "exec ${lib.getExe scripts.control.audio} toggle-sink";
            "XF86AudioMicMute" = "exec ${lib.getExe scripts.control.audio} toggle-source";
            "XF86AudioLowerVolume" = "exec ${lib.getExe scripts.control.audio} decrement-sink";
            "XF86AudioRaiseVolume" = "exec ${lib.getExe scripts.control.audio} increment-sink";

            "XF86MonBrightnessDown" = "exec ${lib.getExe scripts.control.brightness} decrement";
            "XF86MonBrightnessUp" = "exec ${lib.getExe scripts.control.brightness} increment";

            "XF86AudioPlay" = "exec ${lib.getExe scripts.control.mpris} play-pause";
            "XF86AudioPause" = "exec ${lib.getExe scripts.control.mpris} pause";
            "XF86AudioStop" = "exec ${lib.getExe scripts.control.mpris} stop";
            "XF86AudioNext" = "exec ${lib.getExe scripts.control.mpris} next";
            "XF86AudioPrev" = "exec ${lib.getExe scripts.control.mpris} previous";
            "XF86AudioForward" = "exec ${lib.getExe scripts.control.mpris} seek-forward";
            "XF86AudioRewind" = "exec ${lib.getExe scripts.control.mpris} seek-backward";
          };
          modes = {
            RESIZE = {
              "${modifier}+h" = "resize shrink width 10px";
              "${modifier}+j" = "resize grow height 10px";
              "${modifier}+k" = "resize shrink height 10px";
              "${modifier}+l" = "resize grow width 10px";

              "${modifier}+escape" = "mode default";
            };
            MPRIS = {
              "${modifier}+n" = "exec ${lib.getExe scripts.control.mpris} notify-progress";
              "${modifier}+p" = "exec ${lib.getExe scripts.control.mpris} play-pause";
              "${modifier}+l" = "exec ${lib.getExe scripts.control.mpris} next";
              "${modifier}+h" = "exec ${lib.getExe scripts.control.mpris} previous";
              "${modifier}+shift+l" = "exec ${lib.getExe scripts.control.mpris} seek-forward";
              "${modifier}+shift+h" = "exec ${lib.getExe scripts.control.mpris} seek-backward";
              "${modifier}+k" = "exec ${lib.getExe scripts.control.mpris} increment-volume";
              "${modifier}+j" = "exec ${lib.getExe scripts.control.mpris} decrement-volume";
              "${modifier}+shift+k" = "exec ${lib.getExe scripts.control.mpris} next-player";
              "${modifier}+shift+j" = "exec ${lib.getExe scripts.control.mpris} previous-player";

              "${modifier}+escape" = "mode default";
            };
            NOTIFICATION = {
              "${modifier}+m" = "exec ${lib.getExe' pkgs.mako "makoctl"} menu ${lib.getExe pkgs.fzfmenu}";
              "${modifier}+d" = "exec ${lib.getExe' pkgs.mako "makoctl"} dismiss -a";
              "${modifier}+shift+d" = "exec ${lib.getExe' pkgs.mako "makoctl"} mode -t do-not-disturb";

              "${modifier}+escape" = "mode default";
            };
          };
          colors = with colors; {
            background = "#${c00.hex}";
            focused = {
              background = "#${c00.hex}";
              border = "#${c10.hex}";
              childBorder = "#${c10.hex}";
              indicator = "#${c10.hex}";
              text = "#${c10.hex}";
            };
            focusedInactive = {
              background = "#${c00.hex}";
              border = "#${c04.hex}";
              childBorder = "#${c04.hex}";
              indicator = "#${c04.hex}";
              text = "#${c06.hex}";
            };
            unfocused = {
              background = "#${c00.hex}";
              border = "#${c04.hex}";
              childBorder = "#${c04.hex}";
              indicator = "#${c04.hex}";
              text = "#${c06.hex}";
            };
            urgent = {
              background = "#${c00.hex}";
              border = "#${c10.hex}";
              childBorder = "#${c10.hex}";
              indicator = "#${c10.hex}";
              text = "#${c10.hex}";
            };
          };
        };
    };
  };
}
