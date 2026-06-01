_:

{
  flake.modules.homeManager.shared = {
    programs.niri.settings.window-rules = [
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
          { app-id = "^zen$"; }
          { app-id = "^zen-browser$"; }
          { app-id = "^firefox$"; }
        ];
        draw-border-with-background = false;
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
  };
}
