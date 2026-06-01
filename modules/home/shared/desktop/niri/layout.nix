_:

{
  flake.modules.homeManager.shared = {
    programs.niri.settings = {
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
        border.enable = false;
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 0.5;
      };
    };
  };
}
