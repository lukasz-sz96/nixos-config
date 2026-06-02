{
  description = "Python project";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python313
          uv
          ruff
          pyright
          just
        ];

        shellHook = ''
          echo "Python template"
          echo "  uv sync"
          echo "  uv run pytest"
        '';
      };
    };
}
