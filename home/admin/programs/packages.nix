{ inputs, pkgs, ... }:

{
  home.packages =
    (with pkgs; [
      firefox
      file-roller
      nautilus
      obsidian
      sushi
      vscode
      zed-editor
      vesktop
      btop
      fastfetch
      unzip
      tree
      jq
    ])
    ++ [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
  };
}
