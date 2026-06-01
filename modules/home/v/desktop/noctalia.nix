_:

{
  flake.modules.homeManager.v =
    _:

    {
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
            enabled = false;
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
                "kitty"
                "niri"
                "starship"
              ];
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
              "control-center"
              "session"
            ];
          };

          notification.background_opacity = 0.78;
          osd.background_opacity = 0.78;
        };
      };
    };
}
