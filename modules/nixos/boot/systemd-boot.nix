_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      boot = {
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;
        kernelParams = [ "amd_pstate=active" ];

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };
    };
}
