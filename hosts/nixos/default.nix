{ hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/nixos/base
    ../../profiles/nixos/boot
    ../../profiles/nixos/hardware
    ../../profiles/nixos/storage
    ../../profiles/nixos/security
    ../../profiles/nixos/desktop/niri-noctalia
    ../../profiles/nixos/dev
  ];

  networking.hostName = hostName;

  system.stateVersion = "26.05";
}
