_:

{
  flake.modules.homeManager.shared =
    { lib, ... }:

    let
      fallbackNoctaliaTheme = ''
        palette = 0=#372a1b
        palette = 1=#fd4663
        palette = 2=#e4a967
        palette = 3=#d3d65c
        palette = 4=#96ce64
        palette = 5=#ecc293
        palette = 6=#e7e996
        palette = 7=#f3f2f2
        palette = 8=#73695e
        palette = 9=#fd4663
        palette = 10=#e4a967
        palette = 11=#d3d65c
        palette = 12=#96ce64
        palette = 13=#ecc293
        palette = 14=#e7e996
        palette = 15=#f3f2f2
        background = #291f14
        foreground = #f3f2f2
        cursor-color = #f3f2f2
        cursor-text = #291f14
        selection-background = #372a1b
        selection-foreground = #b6b3af
      '';
    in
    {
      programs.ghostty = {
        enable = true;

        settings = {
          background-opacity = 0.52;
          font-family = "JetBrainsMono Nerd Font";
          font-size = 13;
          theme = "noctalia";
          window-padding-x = 10;
          window-padding-y = 10;
        };
      };

      home.activation.seedNoctaliaGhosttyTheme = lib.hm.dag.entryBefore [ "onFilesChange" ] ''
        theme_file="$HOME/.config/ghostty/themes/noctalia"

        if [ ! -e "$theme_file" ]; then
          install -d -m 0755 "$(dirname "$theme_file")"
          cat >"$theme_file" <<'EOF'
        ${fallbackNoctaliaTheme}
        EOF
        fi
      '';
    };
}
