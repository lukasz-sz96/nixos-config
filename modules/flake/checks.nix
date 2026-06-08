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

        niri-layout-overrides =
          pkgs.runCommand "check-niri-layout-overrides"
            {
              niriConfig =
                config.flake.nixosConfigurations.nixos.config.home-manager.users.admin.programs.niri.finalConfig;
              passAsFile = [ "niriConfig" ];
            }
            ''
              grep -F 'workspace "browser"' "$niriConfigPath"
              grep -F 'workspace "code"' "$niriConfigPath"
              grep -F 'workspace "chat"' "$niriConfigPath"
              grep -F 'workspace "gaming"' "$niriConfigPath"
              grep -F 'workspace "aesthetic"' "$niriConfigPath"
              grep -F 'gaps 24' "$niriConfigPath"
              grep -F 'gaps 18' "$niriConfigPath"
              grep -F 'gaps 32' "$niriConfigPath"
              grep -F 'gaps 0' "$niriConfigPath"
              grep -F 'gaps 40' "$niriConfigPath"
              grep -F 'open-on-workspace "browser"' "$niriConfigPath"
              grep -F 'open-on-workspace "code"' "$niriConfigPath"
              grep -F 'open-on-workspace "chat"' "$niriConfigPath"
              grep -F 'open-on-workspace "gaming"' "$niriConfigPath"
              grep -F 'variable-refresh-rate true' "$niriConfigPath"
              touch $out
            '';
      };
    };
}
