{
  home-manager,
  inputs,
  nix-cachyos-kernel,
  nixpkgs,
  noctalia,
}:
{
  hostname,
  modules,
  system ? "x86_64-linux",
  user ? "admin",
}:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs;
    hostName = hostname;
    primaryUser = user;
  };

  modules = modules ++ [
    inputs.niri.nixosModules.niri
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.sops-nix.nixosModules.sops
    home-manager.nixosModules.home-manager

    {
      nixpkgs.overlays = [
        nix-cachyos-kernel.overlays.pinned
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
          inherit user;
        };
        sharedModules = [
          noctalia.homeModules.default
        ];
        users.${user} = import ../users/${user}/home.nix;
      };
    }
  ];
}
