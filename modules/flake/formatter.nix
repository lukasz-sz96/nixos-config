_:

{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.writeShellApplication {
        name = "nixos-config-fmt";
        runtimeInputs = [
          pkgs.findutils
          pkgs.nixfmt
        ];
        text = ''
          format_path() {
            local path="$1"

            if [ -d "$path" ]; then
              while IFS= read -r -d "" file; do
                nixfmt "$file"
              done < <(find "$path" -type f -name "*.nix" -print0)
            elif [ -f "$path" ]; then
              case "$path" in
                *.nix) nixfmt "$path" ;;
              esac
            fi
          }

          args=()

          if [ "$#" -eq 0 ]; then
            args=(".")
          else
            for arg in "$@"; do
              case "$arg" in
                path:*) args+=("''${arg#path:}") ;;
                *) args+=("$arg") ;;
              esac
            done
          fi

          for arg in "''${args[@]}"; do
            format_path "$arg"
          done
        '';
      };
    };
}
