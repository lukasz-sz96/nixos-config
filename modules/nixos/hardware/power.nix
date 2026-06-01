_:

{
  flake.modules.nixos.workstation = {
    services = {
      fwupd.enable = true;
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
  };
}
