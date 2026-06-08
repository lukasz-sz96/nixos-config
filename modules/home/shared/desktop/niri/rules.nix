_:

{
  flake.modules.homeManager.shared = {
    programs.niri.settings.window-rules = [
      {
        geometry-corner-radius = {
          top-left = 18.0;
          top-right = 18.0;
          bottom-right = 18.0;
          bottom-left = 18.0;
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
          { app-id = "^steam$"; }
          { app-id = "^Steam$"; }
          { app-id = "^com\\.heroicgameslauncher\\.hgl$"; }
          { app-id = "^net\\.lutris\\.Lutris$"; }
        ];
        variable-refresh-rate = true;
      }
      {
        matches = [
          {
            title = "^(Open|Save|Save As|Open File|Choose File|Select File|File Upload|Preferences|Settings)$";
          }
        ];
        open-floating = true;
        default-column-width.proportion = 0.5;
        default-window-height.fixed = 720;
      }
    ];
  };
}
