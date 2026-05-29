{ pkgs, ... }:

{
  services.xserver.enable = false;
  services.greetd.enable = false;
  services.displayManager.gdm.enable = false;

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";

    wayland.enable = true;

    extraPackages = with pkgs.kdePackages; [
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
    ];

    settings = {
      General.InputMethod = "";
      Theme = {
        CursorSize = 24;
        CursorTheme = "Adwaita";
      };
    };
  };

  environment.systemPackages = [
    pkgs.adwaita-icon-theme
    pkgs.sddm-astronaut
  ];
}
