{ config, ... }:

{
  flake.modules.homeManager.admin = {
    imports = [
      config.flake.modules.homeManager.shared
    ];

    home = {
      username = "admin";
      homeDirectory = "/home/admin";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
