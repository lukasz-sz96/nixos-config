{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if command -q fnm
        fnm env --use-on-cd --shell fish | source
      end
    '';

    shellInit = ''
      fish_add_path -g $HOME/.local/bin
    '';

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake path:$HOME/nixos-config#nixos";
      update = "nix flake update path:$HOME/nixos-config && sudo nixos-rebuild switch --flake path:$HOME/nixos-config#nixos";
      nc = "cd $HOME/nixos-config";
      ll = "ls -la";
    };
  };
}
