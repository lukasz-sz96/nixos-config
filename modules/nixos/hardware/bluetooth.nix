_:

{
  flake.modules.nixos.workstation = {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
