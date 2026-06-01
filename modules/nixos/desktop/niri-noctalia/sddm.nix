{ inputs, ... }:

{
  flake.modules.nixos.workstation =
    { pkgs, lib, ... }:

    let
      cursorTheme = "Bibata-Modern-Ice";
      cursorSize = 24;

      # Pick one Qylock theme folder name here.
      qylockTheme = "winter";

      defaultCursorTheme = pkgs.runCommand "default-cursor-theme" { } ''
            mkdir -p $out/share/icons/default
            cat > $out/share/icons/default/index.theme <<EOF
        [Icon Theme]
        Inherits=${cursorTheme}
        EOF
      '';

      gstPlugins = with pkgs.gst_all_1; [
        gstreamer
        gst-plugins-base
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ];

      qylockSddmThemes = pkgs.stdenvNoCC.mkDerivation {
        pname = "qylock-sddm-themes";
        version = "git";
        src = inputs.qylock;

        dontBuild = true;

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/sddm/themes

          # Install all normal Qylock themes
          cp -r themes/* $out/share/sddm/themes/

          # Qylock's installer exposes these nested Clockwork variants as separate themes
          cp -r themes/clockwork/orbital $out/share/sddm/themes/orbital
          cp -r themes/clockwork/tape $out/share/sddm/themes/tape

          runHook postInstall
        '';
      };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;

        # Keep the cursor fix that already works for you
        wayland = {
          enable = true;
          compositor = "kwin";
        };

        theme = qylockTheme;

        extraPackages = [
          qylockSddmThemes
          pkgs.bibata-cursors
          defaultCursorTheme

          pkgs.qt6.qtdeclarative
          pkgs.qt6.qt5compat
          pkgs.qt6.qtsvg
          pkgs.qt6.qtmultimedia
          pkgs.qt6.qtwayland
        ]
        ++ gstPlugins;

        settings = {
          General = {
            GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,XCURSOR_THEME=${cursorTheme},XCURSOR_SIZE=${toString cursorSize}";
            InputMethod = "";
          };

          Theme = {
            CursorTheme = cursorTheme;
            CursorSize = cursorSize;
          };
        };
      };

      environment = {
        systemPackages = [
          qylockSddmThemes
          pkgs.bibata-cursors
          defaultCursorTheme
        ];

        variables = {
          XCURSOR_THEME = cursorTheme;
          XCURSOR_SIZE = toString cursorSize;
        };

        pathsToLink = [
          "/share/sddm"
          "/share/icons"
        ];
      };

      systemd.services.display-manager.environment.GST_PLUGIN_SYSTEM_PATH_1_0 =
        lib.makeSearchPath "lib/gstreamer-1.0" gstPlugins;
    };
}
