_:

{
  flake.modules.homeManager.shared = {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        if command -q mise
          mise activate fish | source
        end

        if command -q zoxide
          zoxide init fish | source
        end

        if command -q atuin
          atuin init fish | source
        end
      '';

      shellInit = ''
        fish_add_path -g $HOME/.local/bin
      '';

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake path:$HOME/nixos-config#nixos";
        update = "nix flake update --flake path:$HOME/nixos-config && sudo nixos-rebuild switch --flake path:$HOME/nixos-config#nixos";
        nc = "cd $HOME/nixos-config";
        cat = "bat";
        du = "dust";
        ll = "eza -la --icons=auto --group-directories-first";
        ls = "eza --icons=auto --group-directories-first";
      };
    };
  };
}
