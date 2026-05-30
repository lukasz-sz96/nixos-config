{ pkgs, ... }:

let
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 22;
in
{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = cursorTheme;
    size = cursorSize;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
  };

  programs.niri.settings.environment = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = cursorTheme;
    cursor-size = cursorSize;
  };
}
