{ lib, ... }:

{
  flake.modules.nixos.nixosHardware =
    { modulesPath, ... }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        initrd = {
          availableKernelModules = lib.mkDefault [
            "nvme"
            "xhci_pci"
            "uas"
            "sd_mod"
          ];
          kernelModules = [ ];
        };

        kernelModules = [ ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = [ "subvol=@" ];
        };

        "/home" = {
          device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = [ "subvol=@home" ];
        };

        "/boot" = {
          device = "/dev/disk/by-label/NIXBOOT";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      swapDevices = [ ];

      hardware.enableRedistributableFirmware = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
