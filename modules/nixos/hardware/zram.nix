_:

{
  flake.modules.nixos.workstation = {
    boot.kernel.sysctl = {
      "vm.page-cluster" = 0;
      "vm.swappiness" = 180;
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };
  };
}
