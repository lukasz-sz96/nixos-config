{ config, lib, ... }:

{
  options.workstation.secureBoot.enable = lib.mkEnableOption "Lanzaboote Secure Boot";

  config = lib.mkIf config.workstation.secureBoot.enable {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
