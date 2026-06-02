{
  description = "Rust project";

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
          cargo
          rustc
          rustfmt
          clippy
          pkg-config
          openssl
          just
        ];

        shellHook = ''
          echo "Rust template"
          echo "  cargo run"
          echo "  cargo test"
        '';
      };
    };
}
