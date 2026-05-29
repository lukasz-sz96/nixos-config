{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/boot.nix
    ../../modules/core/locale.nix
    ../../modules/core/nix.nix
    ../../modules/core/users.nix
    ../../modules/core/hardware.nix
    ../../modules/core/packages.nix
    ../../modules/core/fonts.nix

    ../../modules/desktop/wayland.nix
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/niri.nix
    ../../modules/desktop/noctalia.nix

    ../../modules/dev/git.nix
    ../../modules/dev/docker.nix
    ../../modules/dev/web.nix

    ../../modules/security/keyring.nix
  ];

  networking.hostName = "nixos";

  fileSystems."/" = {
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/home" = {
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  system.stateVersion = "26.05";
}
