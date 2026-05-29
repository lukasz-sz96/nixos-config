{ inputs, lib, ... }:

let
  inherit (inputs.niri.lib.kdl)
    leaf
    plain
    ;

  windowOpenShader = ''
    vec4 open_color(vec3 coords_geo, vec3 size_geo) {
        float progress = niri_clamped_progress;
        float opacity = clamp(progress * 1.5, 0.0, 1.0);
        float slide_distance = 0.05;
        float y_offset = (1.0 - progress) * slide_distance;
        float scale = 0.95 + (0.05 * progress);
        vec3 coords = vec3((coords_geo.xy - vec2(0.5, 1.0)) / scale + vec2(0.5, 1.0), 1.0);
        coords.y -= y_offset;
        vec3 coords_tex = niri_geo_to_tex * coords;
        vec4 color = texture2D(niri_tex, coords_tex.st);
        return color * opacity;
    }
  '';

  windowCloseShader = ''
    vec4 close_color(vec3 coords_geo, vec3 size_geo) {
        float progress = 1.0 - niri_clamped_progress;
        float opacity = progress;
        float slide_distance = 0.05;
        float y_offset = (1.0 - progress) * slide_distance;
        float scale = 0.95 + (0.05 * progress);
        vec3 coords = vec3((coords_geo.xy - vec2(0.5, 1.0)) / scale + vec2(0.5, 1.0), 1.0);
        coords.y -= y_offset;
        vec3 coords_tex = niri_geo_to_tex * coords;
        vec4 color = texture2D(niri_tex, coords_tex.st);
        return color * opacity;
    }
  '';
in
{
  programs.niri = {
    config = lib.mkOptionDefault (
      lib.mkAfter [
        (leaf "include" [
          { optional = true; }
          "noctalia.kdl"
        ])
        (plain "window-rule" [
          (plain "background-effect" [
            (leaf "blur" true)
            (leaf "xray" true)
            (leaf "noise" 0.05)
            (leaf "saturation" 2.4)
          ])
        ])
        (plain "layer-rule" [
          (leaf "match" { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel)$"; })
          (plain "background-effect" [
            (leaf "blur" true)
            (leaf "xray" false)
            (leaf "noise" 0.05)
            (leaf "saturation" 2.6)
          ])
        ])
        (plain "blur" [
          (leaf "passes" 3)
          (leaf "offset" 5.0)
          (leaf "noise" 0.04)
          (leaf "saturation" 1.8)
        ])
      ]
    );

    settings = {
      prefer-no-csd = true;

      debug = {
        honor-xdg-activation-with-invalid-serial = [ ];
      };

      input = {
        keyboard.xkb.layout = "pl";
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      layout = {
        gaps = 28;
        center-focused-column = "never";
        focus-ring.enable = true;
        border = {
          enable = false;
        };
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 0.5;
      };

      animations = {
        workspace-switch.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        horizontal-view-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        window-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        window-resize.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        overview-open-close.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 850;
          epsilon = 0.0001;
        };
        window-open = {
          kind.easing = {
            duration-ms = 300;
            curve = "ease-out-cubic";
          };
          custom-shader = windowOpenShader;
        };
        window-close = {
          kind.easing = {
            duration-ms = 200;
            curve = "ease-out-quad";
          };
          custom-shader = windowCloseShader;
        };
        config-notification-open-close.kind.spring = {
          damping-ratio = 0.95;
          stiffness = 900;
          epsilon = 0.001;
        };
        screenshot-ui-open.kind.easing = {
          duration-ms = 200;
          curve = "ease-out-quad";
        };
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-right = 12.0;
            bottom-left = 12.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            { app-id = "^dev\\.noctalia\\.Noctalia\\.Settings$"; }
          ];
          open-floating = true;
          default-column-width.fixed = 1080;
          default-window-height.fixed = 920;
        }
      ];

      spawn-at-startup = [
        { command = [ "noctalia" ]; }
        { command = [ "xwayland-satellite" ]; }
      ];

      binds = {
        "Mod+Return".action.spawn = "ghostty";
        "Mod+T".action.spawn = "kitty";
        "Mod+B".action.spawn = "zen";
        "Mod+Shift+B".action.spawn = [
          "zen"
          "--private-window"
        ];
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
        "Mod+Space".action.spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "launcher"
        ];
        "Mod+S".action.spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "control-center"
        ];
        "Mod+Comma".action.spawn = [
          "noctalia"
          "msg"
          "settings-toggle"
        ];
        "Mod+Shift+W".action.spawn = [
          "noctalia"
          "msg"
          "panel-toggle"
          "wallpaper"
        ];
        "XF86AudioRaiseVolume".action.spawn = [
          "noctalia"
          "msg"
          "volume-up"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "noctalia"
          "msg"
          "volume-down"
        ];
        "XF86AudioMute".action.spawn = [
          "noctalia"
          "msg"
          "volume-mute"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "noctalia"
          "msg"
          "brightness-up"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "noctalia"
          "msg"
          "brightness-down"
        ];
        "XF86AudioPlay".action.spawn = [
          "playerctl"
          "play-pause"
        ];
        "XF86AudioStop".action.spawn = [
          "playerctl"
          "stop"
        ];
        "XF86AudioPrev".action.spawn = [
          "playerctl"
          "previous"
        ];
        "XF86AudioNext".action.spawn = [
          "playerctl"
          "next"
        ];
        "Mod+Q".action.close-window = [ ];

        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Down".action.focus-window-down = [ ];
        "Mod+Up".action.focus-window-up = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+K".action.focus-window-up = [ ];
        "Mod+L".action.focus-column-right = [ ];

        "Mod+Ctrl+Left".action.move-column-left = [ ];
        "Mod+Ctrl+Down".action.move-window-down = [ ];
        "Mod+Ctrl+Up".action.move-window-up = [ ];
        "Mod+Ctrl+Right".action.move-column-right = [ ];
        "Mod+Ctrl+H".action.move-column-left = [ ];
        "Mod+Ctrl+J".action.move-window-down = [ ];
        "Mod+Ctrl+K".action.move-window-up = [ ];
        "Mod+Ctrl+L".action.move-column-right = [ ];

        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];
        "Mod+Ctrl+Home".action.move-column-to-first = [ ];
        "Mod+Ctrl+End".action.move-column-to-last = [ ];

        "Mod+Shift+Left".action.focus-monitor-left = [ ];
        "Mod+Shift+Down".action.focus-monitor-down = [ ];
        "Mod+Shift+Up".action.focus-monitor-up = [ ];
        "Mod+Shift+Right".action.focus-monitor-right = [ ];
        "Mod+Shift+H".action.focus-monitor-left = [ ];
        "Mod+Shift+J".action.focus-monitor-down = [ ];
        "Mod+Shift+K".action.focus-monitor-up = [ ];
        "Mod+Shift+L".action.focus-monitor-right = [ ];

        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [ ];
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+U".action.focus-workspace-down = [ ];
        "Mod+I".action.focus-workspace-up = [ ];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+Page_Down".action.move-workspace-down = [ ];
        "Mod+Shift+Page_Up".action.move-workspace-up = [ ];
        "Mod+Shift+U".action.move-workspace-down = [ ];
        "Mod+Shift+I".action.move-workspace-up = [ ];

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = [ ];
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = [ ];
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = [ ];
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = [ ];
        };
        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;
        "Mod+Tab".action.focus-workspace-previous = [ ];

        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
        "Mod+Shift+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-column-width-back = [ ];
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";
        "Mod+C".action.center-column = [ ];
        "Mod+Ctrl+C".action.center-visible-columns = [ ];
        "Mod+M".action.maximize-column = [ ];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
        "Mod+W".action.toggle-column-tabbed-display = [ ];
        "Mod+O" = {
          repeat = false;
          action.toggle-overview = [ ];
        };
        "Print".action.screenshot = [ ];
        "Mod+E".action.spawn = "nautilus";
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];
        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };
        "Mod+Shift+E".action.quit = [ ];
        "Ctrl+Alt+Delete".action.quit = [ ];
        "Mod+Shift+P".action.power-off-monitors = [ ];
      };
    };
  };
}
