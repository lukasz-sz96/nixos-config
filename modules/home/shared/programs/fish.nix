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
        work = "cd $HOME/Work";
        c = "clear";
        cat = "bat";
        du = "dust";
        ll = "eza -la --icons=auto --group-directories-first";
        ls = "eza --icons=auto --group-directories-first";
        la = "eza -la --icons=auto --group-directories-first";
        lt = "eza --tree --icons=auto --group-directories-first";
        grep = "rg";
        find = "fd";
        top = "btop";
        g = "git";
        gs = "git status --short --branch";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git lg";
        lg = "lazygit";
        ld = "lazydocker";
        k = "kubectl";
        tf = "tofu";
        serve3000 = "serve 3000";
        dcu = "docker compose up -d";
        dcd = "docker compose down";
        dcl = "docker compose logs -f";
        dcp = "docker compose ps";
        ndev = "nix develop";
        nrun = "nix run";
        nshell = "nix shell";
        nsearch = "nix search nixpkgs";
        nixgc = "nix store gc";
        ghpr = "gh pr create";
        ghco = "gh pr checkout";
        ghpv = "gh pr view --web";
      };

      functions = {
        tpl = ''
          if test (count $argv) -lt 1
            echo "usage: tpl <node|bun|python|rust|fullstack|nextjs|tanstack-start|local-services> [directory]"
            return 1
          end

          set template $argv[1]

          if test (count $argv) -ge 2
            nix flake new -t "path:$HOME/nixos-config#$template" -- $argv[2]
          else
            nix flake init -t "path:$HOME/nixos-config#$template"
          end
        '';

        tnode = ''
          tpl node $argv
        '';

        tbun = ''
          tpl bun $argv
        '';

        tpython = ''
          tpl python $argv
        '';

        trustproj = ''
          tpl rust $argv
        '';

        tfull = ''
          tpl fullstack $argv
        '';

        tnext = ''
          if test (count $argv) -ne 1
            echo "usage: tnext <directory>"
            return 1
          end

          tpl nextjs $argv
        '';

        tstart = ''
          if test (count $argv) -ne 1
            echo "usage: tstart <directory>"
            return 1
          end

          tpl tanstack-start $argv
        '';

        tservices = ''
          tpl local-services $argv
        '';

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
