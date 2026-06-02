{ lib, ... }:

{
  flake.modules.homeManager.shared =
    let
      noArg = action: {
        action.${action} = [ ];
      };

      withArg = action: value: {
        action.${action} = value;
      };

      spawn = command: {
        action.spawn = command;
      };

      mkDirectionalBinds =
        modifier:
        {
          left,
          down,
          up,
          right,
        }:
        {
          "${modifier}+Left" = noArg left;
          "${modifier}+Down" = noArg down;
          "${modifier}+Up" = noArg up;
          "${modifier}+Right" = noArg right;
          "${modifier}+H" = noArg left;
          "${modifier}+J" = noArg down;
          "${modifier}+K" = noArg up;
          "${modifier}+L" = noArg right;
        };

      mkWorkspaceNumberBinds =
        modifier: action:
        builtins.listToAttrs (
          map (workspace: {
            name = "${modifier}+${toString workspace}";
            value = withArg action workspace;
          }) (lib.range 1 9)
        );

      mkScrollBinds =
        modifier:
        {
          left,
          right,
          up,
          down,
        }:
        {
          "${modifier}+WheelScrollDown" = {
            cooldown-ms = 150;
            action.${down} = [ ];
          };
          "${modifier}+WheelScrollUp" = {
            cooldown-ms = 150;
            action.${up} = [ ];
          };
          "${modifier}+WheelScrollRight" = noArg right;
          "${modifier}+WheelScrollLeft" = noArg left;
        };

      noctalia =
        command:
        [
          "noctalia"
          "msg"
        ]
        ++ command;
    in
    {
      programs.niri.settings.binds = lib.mkMerge [
        {
          "Mod+Return" = spawn "kitty";
          "Mod+T" = spawn "kitty";
          "Mod+B" = spawn "zen";
          "Mod+Shift+B" = spawn [
            "zen"
            "--private-window"
          ];
          "Mod+E" = spawn "nautilus";
          "Mod+Shift+G" = spawn [
            "kitty"
            "-e"
            "lazygit"
          ];
          "Mod+Shift+D" = spawn [
            "kitty"
            "-e"
            "lazydocker"
          ];
          "Mod+Shift+M" = spawn [
            "kitty"
            "-e"
            "btop"
          ];

          "Mod+Shift+Slash" = noArg "show-hotkey-overlay";
          "Mod+Space" = spawn (noctalia [
            "panel-toggle"
            "launcher"
          ]);
          "Mod+S" = spawn (noctalia [
            "panel-toggle"
            "control-center"
          ]);
          "Mod+Comma" = spawn (noctalia [ "settings-toggle" ]);
          "Mod+Shift+W" = spawn (noctalia [
            "panel-toggle"
            "wallpaper"
          ]);
          "Mod+Ctrl+V" = spawn (noctalia [
            "panel-toggle"
            "clipboard"
          ]);
          "Mod+N" = spawn (noctalia [ "notification-clear-active" ]);
          "Mod+Shift+N" = spawn (noctalia [ "notification-dnd-toggle" ]);
          "Mod+Ctrl+Shift+Space" = spawn (noctalia [ "theme-mode-toggle" ]);
          "Mod+Alt+L" = spawn (noctalia [
            "session"
            "lock"
          ]);
          "Mod+Shift+S" = spawn (noctalia [ "screenshot-region" ]);
          "Mod+Ctrl+Shift+S" = spawn (noctalia [ "screenshot-fullscreen" ]);
          "Mod+Ctrl+Print" = spawn "ocr-region";
          "Mod+Ctrl+Alt+T" = spawn "notice-now";
          "Mod+Ctrl+R" = spawn "remind-prompt";

          "XF86AudioRaiseVolume" = spawn (noctalia [ "volume-up" ]);
          "XF86AudioLowerVolume" = spawn (noctalia [ "volume-down" ]);
          "XF86AudioMute" = spawn (noctalia [ "volume-mute" ]);
          "XF86MonBrightnessUp" = spawn (noctalia [ "brightness-up" ]);
          "XF86MonBrightnessDown" = spawn (noctalia [ "brightness-down" ]);
          "XF86AudioPlay" = spawn [
            "playerctl"
            "play-pause"
          ];
          "XF86AudioStop" = spawn [
            "playerctl"
            "stop"
          ];
          "XF86AudioPrev" = spawn [
            "playerctl"
            "previous"
          ];
          "XF86AudioNext" = spawn [
            "playerctl"
            "next"
          ];

          "Mod+Q" = noArg "close-window";
          "Mod+Home" = noArg "focus-column-first";
          "Mod+End" = noArg "focus-column-last";
          "Mod+Ctrl+Home" = noArg "move-column-to-first";
          "Mod+Ctrl+End" = noArg "move-column-to-last";
          "Mod+Page_Down" = noArg "focus-workspace-down";
          "Mod+Page_Up" = noArg "focus-workspace-up";
          "Mod+U" = noArg "focus-workspace-down";
          "Mod+I" = noArg "focus-workspace-up";
          "Mod+Ctrl+Page_Down" = noArg "move-column-to-workspace-down";
          "Mod+Ctrl+Page_Up" = noArg "move-column-to-workspace-up";
          "Mod+Ctrl+U" = noArg "move-column-to-workspace-down";
          "Mod+Ctrl+I" = noArg "move-column-to-workspace-up";
          "Mod+Shift+Page_Down" = noArg "move-workspace-down";
          "Mod+Shift+Page_Up" = noArg "move-workspace-up";
          "Mod+Shift+U" = noArg "move-workspace-down";
          "Mod+Shift+I" = noArg "move-workspace-up";
          "Mod+Tab" = noArg "focus-workspace-previous";

          "Mod+BracketLeft" = noArg "consume-or-expel-window-left";
          "Mod+BracketRight" = noArg "consume-or-expel-window-right";
          "Mod+Shift+Comma" = noArg "consume-window-into-column";
          "Mod+Period" = noArg "expel-window-from-column";
          "Mod+R" = noArg "switch-preset-column-width";
          "Mod+Shift+R" = noArg "switch-preset-column-width-back";
          "Mod+Minus" = withArg "set-column-width" "-10%";
          "Mod+Equal" = withArg "set-column-width" "+10%";
          "Mod+Shift+Minus" = withArg "set-window-height" "-10%";
          "Mod+Shift+Equal" = withArg "set-window-height" "+10%";
          "Mod+C" = noArg "center-column";
          "Mod+Ctrl+C" = noArg "center-visible-columns";
          "Mod+M" = noArg "maximize-column";
          "Mod+Ctrl+F" = noArg "expand-column-to-available-width";
          "Mod+F" = noArg "maximize-column";
          "Mod+Shift+F" = noArg "fullscreen-window";
          "Mod+V" = noArg "toggle-window-floating";
          "Mod+Shift+V" = noArg "switch-focus-between-floating-and-tiling";
          "Mod+W" = noArg "toggle-column-tabbed-display";
          "Mod+O" = {
            repeat = false;
            action.toggle-overview = [ ];
          };
          "Print" = noArg "screenshot";
          "Ctrl+Print" = noArg "screenshot-screen";
          "Alt+Print" = noArg "screenshot-window";
          "Mod+Escape" = {
            allow-inhibiting = false;
            action.toggle-keyboard-shortcuts-inhibit = [ ];
          };
          "Mod+Shift+E" = noArg "quit";
          "Ctrl+Alt+Delete" = noArg "quit";
          "Mod+Shift+P" = noArg "power-off-monitors";
        }

        (mkDirectionalBinds "Mod" {
          left = "focus-column-left";
          down = "focus-window-down";
          up = "focus-window-up";
          right = "focus-column-right";
        })

        (mkDirectionalBinds "Mod+Ctrl" {
          left = "move-column-left";
          down = "move-window-down";
          up = "move-window-up";
          right = "move-column-right";
        })

        (mkDirectionalBinds "Mod+Shift" {
          left = "focus-monitor-left";
          down = "focus-monitor-down";
          up = "focus-monitor-up";
          right = "focus-monitor-right";
        })

        (mkDirectionalBinds "Mod+Shift+Ctrl" {
          left = "move-column-to-monitor-left";
          down = "move-column-to-monitor-down";
          up = "move-column-to-monitor-up";
          right = "move-column-to-monitor-right";
        })

        (mkScrollBinds "Mod" {
          left = "focus-column-left";
          right = "focus-column-right";
          up = "focus-workspace-up";
          down = "focus-workspace-down";
        })

        (mkScrollBinds "Mod+Ctrl" {
          left = "move-column-left";
          right = "move-column-right";
          up = "move-column-to-workspace-up";
          down = "move-column-to-workspace-down";
        })

        (mkWorkspaceNumberBinds "Mod" "focus-workspace")
        (mkWorkspaceNumberBinds "Mod+Ctrl" "move-column-to-workspace")
      ];
    };
}
