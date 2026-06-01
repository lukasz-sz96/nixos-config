_:

{
  flake.modules.homeManager.admin = {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 13;
      };

      settings = {
        background_opacity = "0.52";
        confirm_os_window_close = 0;
        cursor_shape = "beam";
        cursor_trail = 1;
        window_margin_width = 10;
      };

      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+f" =
          "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
        "kitty_mod+f" =
          "launch --location=hsplit --allow-remote-control kitty +kitten search.py @active-kitty-window-id";
        "page_down" = "scroll_page_down";
        "page_up" = "scroll_page_up";
        "ctrl+plus" = "change_font_size all +1";
        "ctrl+equal" = "change_font_size all +1";
        "ctrl+kp_add" = "change_font_size all +1";
        "ctrl+minus" = "change_font_size all -1";
        "ctrl+underscore" = "change_font_size all -1";
        "ctrl+kp_subtract" = "change_font_size all -1";
        "ctrl+0" = "change_font_size all 0";
        "ctrl+kp_0" = "change_font_size all 0";
      };

      extraConfig = ''
        include themes/noctalia.conf
      '';
    };
  };
}
