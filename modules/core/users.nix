{ pkgs, ... }:

{
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
