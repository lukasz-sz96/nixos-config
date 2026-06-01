{ config, inputs, ... }:

{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.niri.nixosModules.niri
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../../hosts/nixos/hardware-configuration.nix
      config.flake.modules.nixos.workstation

      {
        networking.hostName = "nixos";
        system.stateVersion = "26.05";

        nixpkgs.overlays = [
          inputs.nix-cachyos-kernel.overlays.pinned
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          sharedModules = [
            inputs.noctalia.homeModules.default
          ];
          users.admin = config.flake.modules.homeManager.admin;
          users.v = config.flake.modules.homeManager.v;
        };
      }
    ];
  };
}
