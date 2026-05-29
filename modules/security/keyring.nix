{ pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    age
    libsecret
    pass
    seahorse
    sops
    ssh-to-age
  ];
}
