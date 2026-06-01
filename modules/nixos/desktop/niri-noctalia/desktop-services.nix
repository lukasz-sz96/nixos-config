_:

{
  flake.modules.nixos.workstation = {
    hardware.sane.enable = true;

    programs.steam.enable = true;

    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      flatpak.enable = true;
      printing.enable = true;
      tumbler.enable = true;
    };
  };
}
