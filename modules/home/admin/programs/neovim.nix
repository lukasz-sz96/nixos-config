_:

{
  flake.modules.homeManager.admin =
    { pkgs, ... }:

    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      home.packages = with pkgs; [
        fd
        fzf
        gcc
        gnumake
        lazygit
        ripgrep
        tree-sitter
      ];

      xdg.configFile."nvim" = {
        source = ../config/nvim;
        recursive = true;
      };
    };
}
