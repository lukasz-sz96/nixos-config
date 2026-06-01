{ inputs, ... }:

{
  flake.modules.homeManager.shared =
    { pkgs, ... }:

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
          loupe
          nautilus
          papers
          sushi
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
          duf
          dust
          eza
          fastfetch
          fd
          fzf
          hyperfine
          jq
          procs
          ripgrep-all
          tokei
          tree
          unzip
          zoxide

          # Infra
          k9s
          kubectl
          kubernetes-helm
          lazydocker
          opentofu
        ])
        ++ [
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

          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          "application/x-rar" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-xz" = "org.gnome.FileRoller.desktop";

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
