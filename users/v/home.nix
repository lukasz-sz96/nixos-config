_:

{
  imports = [
    ./programs/packages.nix
    ./programs/neovim.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/starship.nix
    ./programs/ghostty.nix
    ./programs/kitty.nix

    ./desktop/niri.nix
    ./desktop/noctalia.nix
    ./desktop/cursor.nix
  ];

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
}
