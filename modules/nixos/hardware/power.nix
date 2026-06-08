_:

{
  flake.modules.nixos.workstation = {
    services = {
      fwupd.enable = true;
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    systemd.services.fwupd-refresh = {
      after = [ "polkit.service" ];
      wants = [ "polkit.service" ];
    };
  };
}
