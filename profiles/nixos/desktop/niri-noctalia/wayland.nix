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
  };

  environment.systemPackages = with pkgs; [
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
}
