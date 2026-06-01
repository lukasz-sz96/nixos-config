{ inputs, ... }:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
