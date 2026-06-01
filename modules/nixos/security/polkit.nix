_:

{
  flake.modules.nixos.workstation = {
    networking.firewall.enable = true;
    security.polkit.enable = true;
  };
}
