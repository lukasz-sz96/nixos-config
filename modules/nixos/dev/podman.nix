_:

{
  flake.modules.nixos.workstation =
    { lib, ... }:

    {
      virtualisation.podman = {
        enable = lib.mkDefault false;
        dockerCompat = lib.mkDefault false;
      };
    };
}
