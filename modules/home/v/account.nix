_:

{
  flake.modules.homeManager.v = {
    home = {
      username = "v";
      homeDirectory = "/home/v";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
