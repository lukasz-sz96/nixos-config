{ inputs, ... }:

{
  flake.modules.homeManager.shared =
    { pkgs, ... }:

    let
      ocrRegion = pkgs.writeShellApplication {
        name = "ocr-region";
        runtimeInputs = with pkgs; [
          coreutils
          gnused
          grim
          libnotify
          slurp
          tesseract
          wl-clipboard
        ];
        text = ''
          image="$(mktemp --suffix=.png)"
          trap 'rm -f "$image"' EXIT

          geometry="$(slurp)" || exit 0
          grim -g "$geometry" "$image"

          text="$(tesseract "$image" stdout --psm 6 2>/dev/null | sed '/^[[:space:]]*$/d')"
          if [ -n "$text" ]; then
            printf '%s' "$text" | wl-copy
            notify-send "OCR copied" "Recognized text is in the clipboard."
          else
            notify-send "OCR empty" "No text was recognized in the selected region."
          fi
        '';
      };

      remind = pkgs.writeShellApplication {
        name = "remind";
        runtimeInputs = with pkgs; [
          coreutils
          libnotify
          systemd
        ];
        text = ''
          if [ "$#" -lt 2 ]; then
            echo "usage: remind <delay> <message...>"
            echo "example: remind 20m stretch"
            exit 1
          fi

          delay="$1"
          shift
          message="$*"
          unit="reminder-$(date +%s)"

          systemd-run --user --quiet --unit="$unit" --on-active="$delay" \
            ${pkgs.libnotify}/bin/notify-send "Reminder" "$message"
        '';
      };

      noticeNow = pkgs.writeShellApplication {
        name = "notice-now";
        runtimeInputs = with pkgs; [
          coreutils
          libnotify
        ];
        text = ''
          notify-send "Now" "$(date '+%A, %d %B %Y %H:%M')"
        '';
      };
    in
    {
      home.packages =
        (with pkgs; [
          # Desktop
          firefox
          obsidian
          vscode
          zed-editor
          vesktop
          bruno
          dbeaver-bin

          # Files/media
          celluloid
          file-roller
          kdePackages.breeze-icons
          nautilus
          loupe
          papers
          mpv
          obs-studio
          resources
          mission-center

          # Games
          heroic
          lutris
          gamescope
          mangohud

          # Music
          spicetify-cli

          # CLI
          atuin
          bat
          btop
          comma
          duf
          dust
          entr
          eza
          fastfetch
          fd
          fzf
          gh-dash
          hyperfine
          jq
          just
          lsof
          mailpit
          nh
          nix-index
          nix-output-monitor
          nvd
          procs
          python313
          ripgrep-all
          tmux
          tokei
          tree
          unzip
          watchexec
          yazi
          zoxide

          # Infra
          k9s
          kubectl
          kubernetes-helm
          lazydocker
          opentofu
        ])
        ++ [
          noticeNow
          ocrRegion
          remind
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = "org.gnome.Nautilus.desktop";
          "text/html" = "zen.desktop";
          "text/xml" = "zen.desktop";
          "application/xhtml+xml" = "zen.desktop";
          "application/xml" = "zen.desktop";
          "x-scheme-handler/http" = "zen.desktop";
          "x-scheme-handler/https" = "zen.desktop";

          "application/pdf" = "org.gnome.Papers.desktop";
          "application/x-bzpdf" = "org.gnome.Papers.desktop";
          "application/x-gzpdf" = "org.gnome.Papers.desktop";
          "application/x-xzpdf" = "org.gnome.Papers.desktop";

          "image/avif" = "org.gnome.Loupe.desktop";
          "image/bmp" = "org.gnome.Loupe.desktop";
          "image/gif" = "org.gnome.Loupe.desktop";
          "image/heic" = "org.gnome.Loupe.desktop";
          "image/jpeg" = "org.gnome.Loupe.desktop";
          "image/jxl" = "org.gnome.Loupe.desktop";
          "image/png" = "org.gnome.Loupe.desktop";
          "image/svg+xml" = "org.gnome.Loupe.desktop";
          "image/tiff" = "org.gnome.Loupe.desktop";
          "image/webp" = "org.gnome.Loupe.desktop";

          "audio/flac" = "io.github.celluloid_player.Celluloid.desktop";
          "audio/mp4" = "io.github.celluloid_player.Celluloid.desktop";
          "audio/mpeg" = "io.github.celluloid_player.Celluloid.desktop";
          "audio/ogg" = "io.github.celluloid_player.Celluloid.desktop";
          "audio/wav" = "io.github.celluloid_player.Celluloid.desktop";
          "audio/webm" = "io.github.celluloid_player.Celluloid.desktop";
          "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
          "video/mpeg" = "io.github.celluloid_player.Celluloid.desktop";
          "video/quicktime" = "io.github.celluloid_player.Celluloid.desktop";
          "video/webm" = "io.github.celluloid_player.Celluloid.desktop";
          "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
          "video/x-msvideo" = "io.github.celluloid_player.Celluloid.desktop";

          "application/bzip2" = "org.gnome.FileRoller.desktop";
          "application/gzip" = "org.gnome.FileRoller.desktop";
          "application/vnd.rar" = "org.gnome.FileRoller.desktop";
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/zstd" = "org.gnome.FileRoller.desktop";
          "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
          "application/x-bzip" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-bzip-compressed-tar" = "org.gnome.FileRoller.desktop";
          "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          "application/x-rar" = "org.gnome.FileRoller.desktop";
          "application/x-rar-compressed" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-xz" = "org.gnome.FileRoller.desktop";
          "application/x-xz-compressed-tar" = "org.gnome.FileRoller.desktop";

          "application/json" = "dev.zed.Zed.desktop";
          "application/x-yaml" = "dev.zed.Zed.desktop";
          "text/css" = "dev.zed.Zed.desktop";
          "text/javascript" = "dev.zed.Zed.desktop";
          "text/markdown" = "dev.zed.Zed.desktop";
          "text/plain" = "dev.zed.Zed.desktop";
          "text/x-python" = "dev.zed.Zed.desktop";
          "text/x-shellscript" = "dev.zed.Zed.desktop";
          "text/yaml" = "dev.zed.Zed.desktop";
        };
      };
    };
}
