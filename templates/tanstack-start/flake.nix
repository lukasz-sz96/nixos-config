{
  description = "TanStack Start generator workspace";

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
          nodejs_24
          corepack
          bun
          just
        ];

        shellHook = ''
          corepack enable pnpm >/dev/null 2>&1 || true
          echo "TanStack Start generator template"
          echo "  just bootstrap"
        '';
      };
    };
}
