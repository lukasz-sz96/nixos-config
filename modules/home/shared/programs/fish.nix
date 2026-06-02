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
        rebuild = "nh os switch path:$HOME/nixos-config#nixos";
        update = "nix flake update --flake path:$HOME/nixos-config && nh os switch path:$HOME/nixos-config#nixos";
        check = "nix flake check --no-build path:$HOME/nixos-config";
        drybuild = "nix build path:$HOME/nixos-config#nixosConfigurations.nixos.config.system.build.toplevel --dry-run";
        diff = "nix build path:$HOME/nixos-config#nixosConfigurations.nixos.config.system.build.toplevel && nvd diff /run/current-system result";
        doctor = "check && drybuild";
        ports = "lsof -Pan -iTCP -sTCP:LISTEN";
        nc = "cd $HOME/nixos-config";
        cat = "bat";
        du = "dust";
        ll = "eza -la --icons=auto --group-directories-first";
        ls = "eza --icons=auto --group-directories-first";
      };

      functions = {
        mkcd = ''
          mkdir -p -- $argv[1]
          and cd -- $argv[1]
        '';

        extract = ''
          if test (count $argv) -ne 1
            echo "usage: extract <archive>"
            return 1
          end

          switch $argv[1]
            case "*.tar.bz2" "*.tbz2"
              tar xjf $argv[1]
            case "*.tar.gz" "*.tgz"
              tar xzf $argv[1]
            case "*.tar.xz" "*.txz"
              tar xJf $argv[1]
            case "*.tar.zst" "*.tzst"
              tar --zstd -xf $argv[1]
            case "*.tar"
              tar xf $argv[1]
            case "*.zip"
              unzip $argv[1]
            case "*.gz"
              gunzip $argv[1]
            case "*.bz2"
              bunzip2 $argv[1]
            case "*.xz"
              unxz $argv[1]
            case "*"
              echo "extract: unsupported archive: $argv[1]"
              return 1
          end
        '';

        compress = ''
          if test (count $argv) -ne 1
            echo "usage: compress <file-or-directory>"
            return 1
          end

          set target (string replace -r '/$' "" -- $argv[1])
          tar czf "$target.tar.gz" -- "$target"
        '';

        serve = ''
          set port 8000
          if test (count $argv) -ge 1
            set port $argv[1]
          end

          python3 -m http.server $port
        '';

        fip = ''
          if test (count $argv) -lt 2
            echo "usage: fip <remote> <port> [port...]"
            return 1
          end

          set remote $argv[1]
          for port in $argv[2..-1]
            set socket "$XDG_RUNTIME_DIR/ssh-fwd-$remote-$port"
            ssh -M -S "$socket" -fN -L "$port:localhost:$port" "$remote"
            echo "forwarded localhost:$port -> $remote:localhost:$port"
          end
        '';

        dip = ''
          if test (count $argv) -lt 2
            echo "usage: dip <remote> <port> [port...]"
            return 1
          end

          set remote $argv[1]
          for port in $argv[2..-1]
            set socket "$XDG_RUNTIME_DIR/ssh-fwd-$remote-$port"
            ssh -S "$socket" -O exit "$remote"
          end
        '';

        lip = ''
          command ls "$XDG_RUNTIME_DIR"/ssh-fwd-* 2>/dev/null
        '';
      };
    };
  };
}
