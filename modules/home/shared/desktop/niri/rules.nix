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
        default-column-width.proportion = 0.66667;
        draw-border-with-background = false;
      }
      {
        matches = [
          { app-id = "^dev\\.zed\\.Zed$"; }
          { app-id = "^code$"; }
          { app-id = "^Code$"; }
          { app-id = "^VSCodium$"; }
        ];
        default-column-width.proportion = 0.66667;
      }
      {
        matches = [
          { app-id = "^obsidian$"; }
          { app-id = "^md\\.obsidian\\.Obsidian$"; }
        ];
        default-column-width.proportion = 0.66667;
      }
      {
        matches = [
          { app-id = "^vesktop$"; }
          { app-id = "^dev\\.vencord\\.Vesktop$"; }
        ];
        default-column-width.proportion = 0.5;
      }
      {
        matches = [
          { app-id = "^bruno$"; }
          { app-id = "^com\\.usebruno\\.Bruno$"; }
          { app-id = "^DBeaver$"; }
          { app-id = "^dbeaver$"; }
          { app-id = "^org\\.jkiss\\.dbeaver\\.core\\.DBeaver$"; }
        ];
        default-column-width.proportion = 0.66667;
      }
      {
        matches = [
          { app-id = "^org\\.gnome\\.Nautilus$"; }
          { app-id = "^org\\.gnome\\.FileRoller$"; }
          { app-id = "^org\\.gnome\\.Loupe$"; }
          { app-id = "^org\\.gnome\\.Papers$"; }
          { app-id = "^io\\.github\\.celluloid_player\\.Celluloid$"; }
          { app-id = "^mpv$"; }
          { app-id = "^pavucontrol$"; }
        ];
        open-floating = true;
        default-column-width.proportion = 0.5;
      }
      {
        matches = [
          { app-id = "^com\\.obsproject\\.Studio$"; }
          { app-id = "^obs$"; }
        ];
        default-column-width.proportion = 1.0;
      }
      {
        matches = [
          { app-id = "^steam$"; }
          { app-id = "^Steam$"; }
          { app-id = "^com\\.heroicgameslauncher\\.hgl$"; }
          { app-id = "^net\\.lutris\\.Lutris$"; }
        ];
        default-column-width.proportion = 1.0;
        variable-refresh-rate = true;
      }
      {
        matches = [
          {
            title = "^(Open|Save|Save As|Open File|Choose File|Select File|File Upload|Preferences|Settings)$";
          }
        ];
        open-floating = true;
        default-column-width.fixed = 960;
        default-window-height.fixed = 720;
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
