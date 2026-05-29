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
      Theme.CursorTheme = "Adwaita";
    };
  };

  environment.systemPackages = [
    pkgs.sddm-astronaut
  ];
}
