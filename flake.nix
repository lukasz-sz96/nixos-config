{
  description = "NixOS Niri Noctalia setup";

  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v5";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      niri,
      nix-cachyos-kernel,
      noctalia,
      zen-browser,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
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

      formatter.${system} = pkgs.writeShellApplication {
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

      checks.${system} = {
        nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;

        format =
          pkgs.runCommand "check-nix-format"
            {
              nativeBuildInputs = [
                pkgs.findutils
                pkgs.nixfmt
              ];
            }
            ''
              cp -r ${self} source
              chmod -R u+w source
              cd source
              find . -path ./.git -prune -o -type f -name "*.nix" -print0 | xargs -0 nixfmt --check
              touch $out
            '';

        deadnix =
          pkgs.runCommand "check-deadnix"
            {
              nativeBuildInputs = [
                pkgs.deadnix
              ];
            }
            ''
              deadnix --fail ${self}
              touch $out
            '';

        statix =
          pkgs.runCommand "check-statix"
            {
              nativeBuildInputs = [
                pkgs.statix
              ];
            }
            ''
              statix check ${self}
              touch $out
            '';
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/nixos/configuration.nix
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager

          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.sharedModules = [
              noctalia.homeModules.default
            ];

            home-manager.users.admin = import ./home/admin/home.nix;
          }
        ];
      };
    };
}
