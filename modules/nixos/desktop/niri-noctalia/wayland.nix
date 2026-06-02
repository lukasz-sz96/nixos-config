_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      programs.dconf.enable = true;

      services.gvfs.enable = true;
      services.udisks2.enable = true;

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
        config.niri = {
          default = [
            "gnome"
            "gtk"
          ];

          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];

          "org.freedesktop.impl.portal.Access" = [ "gtk" ];
          "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        wl-clipboard
        grim
        slurp
        swappy
        brightnessctl
        playerctl
        pamixer
        pavucontrol
        networkmanagerapplet
      ];
    };
}
