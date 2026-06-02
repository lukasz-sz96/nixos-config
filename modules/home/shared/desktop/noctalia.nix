_:

{
  flake.modules.homeManager.shared =
    { config, pkgs, ... }:

    let
      qtctSettings = qtct: {
        Appearance = {
          color_scheme_path = "${config.home.homeDirectory}/.config/${qtct}/colors/noctalia.conf";
          custom_palette = true;
          icon_theme = "breeze-dark";
          standard_dialogs = "xdgdesktopportal";
          style = "kvantum";
        };

        Interface = {
          activate_item_on_single_click = 1;
          buttonbox_layout = 0;
          cursor_flash_time = 1000;
          dialog_buttons_have_icons = 1;
          double_click_interval = 400;
          keyboard_scheme = 2;
          menus_have_icons = true;
          show_shortcuts_in_context_menus = true;
          toolbutton_style = 4;
          underline_shortcut = 1;
          wheel_scroll_lines = 3;
        };
      };
    in

    {
      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
        qt5ctSettings = qtctSettings "qt5ct";
        qt6ctSettings = qtctSettings "qt6ct";

        kvantum = {
          enable = true;
          settings.General.theme = "Noctalia";
        };
      };

      programs.noctalia = {
        enable = true;

        settings = {
          shell = {
            corner_radius_scale = 1.15;

            shadow = {
              direction = "down";
              alpha = 0.65;
            };

            panel = {
              background_blur = true;
              transparency_mode = "glass";
              borders = true;
              shadow = true;
              launcher_placement = "centered";
              clipboard_placement = "centered";
              control_center_placement = "attached";
              wallpaper_placement = "attached";
              session_placement = "attached";
            };
          };

          backdrop = {
            enabled = true;
            blur_intensity = 0.85;
            tint_intensity = 0.45;
          };

          theme = {
            mode = "dark";
            source = "wallpaper";
            wallpaper_scheme = "vibrant";

            templates = {
              enable_builtin_templates = true;
              builtin_ids = [
                "ghostty"
                "kcolorscheme"
                "kitty"
                "niri"
                "qt"
                "starship"
              ];

              user.kvantum = {
                input_path = "$XDG_CONFIG_HOME/noctalia/templates/kvantum/Noctalia.kvconfig";
                output_path = "$XDG_CONFIG_HOME/Kvantum/Noctalia/Noctalia.kvconfig";
                index = 20;
              };
            };
          };

          wallpaper = {
            enabled = true;
            fill_mode = "crop";
            transition = [
              "fade"
              "wipe"
              "disc"
              "stripes"
              "zoom"
              "honeycomb"
            ];
            transition_duration = 1500;
            edge_smoothness = 0.3;
            directory = "~/Pictures/Wallpapers";
          };

          bar.default = {
            background_opacity = 0.58;
            radius = 14;
            margin_h = 180;
            margin_v = 10;
            shadow = true;
            start = [
              "launcher"
              "wallpaper"
              "workspaces"
              "active_window"
            ];
            center = [
              "clock"
            ];
            end = [
              "media"
              "tray"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "battery"
              "screenshot"
              "theme_mode"
              "control-center"
              "session"
            ];
          };

          notification.background_opacity = 0.78;
          osd.background_opacity = 0.78;
        };
      };

      xdg.configFile = {
        "noctalia/templates/kvantum/Noctalia.kvconfig".source =
          ../config/noctalia/templates/kvantum/Noctalia.kvconfig;

        "Kvantum/Noctalia/Noctalia.svg".source =
          "${pkgs.qt6Packages.qtstyleplugin-kvantum}/share/Kvantum/KvAdaptaDark/KvAdaptaDark.svg";
      };
    };
}
