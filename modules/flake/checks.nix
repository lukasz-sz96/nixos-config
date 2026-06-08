{ config, inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        nixos = config.flake.nixosConfigurations.nixos.config.system.build.toplevel;

        format =
          pkgs.runCommand "check-nix-format"
            {
              nativeBuildInputs = [
                pkgs.findutils
                pkgs.nixfmt
              ];
            }
            ''
              cp -r ${inputs.self} source
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
              deadnix --fail ${inputs.self}
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
              statix check ${inputs.self}
              touch $out
            '';

        niri-no-app-workflows =
          pkgs.runCommand "check-niri-no-app-workflows"
            {
              niriConfig =
                config.flake.nixosConfigurations.nixos.config.home-manager.users.admin.programs.niri.finalConfig;
              passAsFile = [ "niriConfig" ];
            }
            ''
              grep -F 'default-column-width { proportion 0.500000; }' "$niriConfigPath"

              if grep -F 'open-on-workspace' "$niriConfigPath"; then
                echo "app-specific workspace routing is disabled" >&2
                exit 1
              fi

              for width in \
                'default-column-width { fixed ' \
                'default-column-width { proportion 0.333330; }' \
                'default-column-width { proportion 0.666670; }' \
                'default-column-width { proportion 0.750000; }' \
                'default-column-width { proportion 1.000000; }'
              do
                if grep -F "$width" "$niriConfigPath"; then
                  echo "non-half default column widths are disabled" >&2
                  exit 1
                fi
              done

              for workspace in browser code chat gaming aesthetic; do
                if grep -F "workspace \"$workspace\"" "$niriConfigPath"; then
                  echo "app-specific workflow workspace '$workspace' is disabled" >&2
                  exit 1
                fi
              done

              touch $out
            '';

        fwupd-refresh-polkit-ordering =
          let
            fwupdRefresh = config.flake.nixosConfigurations.nixos.config.systemd.services.fwupd-refresh;
          in
          pkgs.runCommand "check-fwupd-refresh-polkit-ordering" { } ''
            ${
              if builtins.elem "polkit.service" fwupdRefresh.wants then
                "true"
              else
                "echo 'fwupd-refresh.service should want polkit.service' >&2; exit 1"
            }
            ${
              if builtins.elem "polkit.service" fwupdRefresh.after then
                "true"
              else
                "echo 'fwupd-refresh.service should start after polkit.service' >&2; exit 1"
            }
            touch $out
          '';
      };
    };
}
