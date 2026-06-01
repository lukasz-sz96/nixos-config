_:

{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          deadnix
          git
          nil
          nixd
          nixfmt
          statix
        ];

        shellHook = ''
          echo "nixos-config dev shell"
          echo "  nix fmt          format Nix files"
          echo "  nix flake check  run system and lint checks"
        '';
      };
    };
}
