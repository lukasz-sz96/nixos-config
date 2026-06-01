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
      };
    };
}
