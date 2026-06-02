{
  description = "TypeScript Bun service";

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
          bun
          just
        ];

        shellHook = ''
          echo "Bun template"
          echo "  bun install"
          echo "  bun dev"
        '';
      };
    };
}
