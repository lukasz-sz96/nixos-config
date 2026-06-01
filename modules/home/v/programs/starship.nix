_:

{
  flake.modules.homeManager.v =
    { lib, pkgs, ... }:

    let
      baseConfig = builtins.fromTOML (
        builtins.readFile ../config/noctalia/templates/starship-caelestia.toml
      );
      tomlFormat = pkgs.formats.toml { };
    in
    {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
      };

      xdg.configFile."starship/base.toml".source = tomlFormat.generate "starship-base.toml" baseConfig;

      home.activation.applyNoctaliaStarshipPalette = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        base_file="$HOME/.config/starship/base.toml"
        palette_file="$HOME/.cache/noctalia/starship-palette.toml"
        config_file="$HOME/.config/starship.toml"
        marker_begin="# >>> NOCTALIA STARSHIP PALETTE >>>"
        marker_end="# <<< NOCTALIA STARSHIP PALETTE <<<"

        if [ -f "$base_file" ]; then
          tmp_file="$(mktemp)"
          cp "$(readlink -f "$base_file")" "$tmp_file"

          if [ -f "$palette_file" ]; then
            {
              echo ""
              echo "$marker_begin"
              cat "$palette_file"
              echo "$marker_end"
            } >>"$tmp_file"
          fi

          rm -f "$config_file"
          install -m 0644 "$tmp_file" "$config_file"
          rm -f "$tmp_file"
        fi
      '';
    };
}
