{ ... }:

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

  home.username = "admin";
  home.homeDirectory = "/home/admin";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
