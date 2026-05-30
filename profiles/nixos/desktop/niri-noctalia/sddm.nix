{ pkgs, ... }:

let
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 24;

  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
  };
in
{
  services = {
    xserver.enable = false;
    greetd.enable = false;

    displayManager = {
      defaultSession = "niri";
      gdm.enable = false;

      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";

        wayland = {
          enable = true;
          compositor = "weston";
        };

        enableHidpi = true;

        extraPackages = [
          custom-sddm-astronaut
          pkgs.bibata-cursors

          pkgs.kdePackages.qtmultimedia
          pkgs.kdePackages.qtsvg
          pkgs.kdePackages.qtvirtualkeyboard
        ];

        settings = {
          Theme = {
            Current = "sddm-astronaut-theme";
            CursorTheme = cursorTheme;
            CursorSize = cursorSize;
          };

          General = {
            DefaultSession = "niri.desktop";
          };
        };
      };
    };
  };

  programs.niri.enable = true;

  environment.systemPackages = [
    custom-sddm-astronaut
    pkgs.bibata-cursors
    pkgs.adwaita-icon-theme
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
  };

  systemd.services.display-manager.environment = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
    XCURSOR_PATH = "${pkgs.bibata-cursors}/share/icons:/run/current-system/sw/share/icons";
  };
}
