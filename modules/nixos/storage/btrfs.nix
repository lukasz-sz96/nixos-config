_:

{
  flake.modules.nixos.workstation = {
    fileSystems = {
      "/" = {
        options = [
          "compress=zstd"
          "noatime"
        ];
      };

      "/home" = {
        options = [
          "compress=zstd"
          "noatime"
        ];
      };
    };

    services = {
      btrfs.autoScrub = {
        enable = true;
        fileSystems = [ "/" ];
        interval = "weekly";
      };

      fstrim.enable = true;
    };
  };
}
