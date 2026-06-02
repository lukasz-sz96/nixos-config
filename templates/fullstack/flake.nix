{
  description = "TypeScript full-stack service";

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
          docker-compose
          postgresql_17
          redis
          mailpit
          just
        ];

        shellHook = ''
          corepack enable pnpm >/dev/null 2>&1 || true
          echo "Fullstack template"
          echo "  docker compose up -d"
          echo "  pnpm install"
          echo "  pnpm dev"
        '';
      };
    };
}
