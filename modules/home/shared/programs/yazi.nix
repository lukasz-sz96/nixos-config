_:

{
  flake.modules.homeManager.shared =
    { pkgs, ... }:

    {
      programs.yazi = {
        enable = true;
        enableFishIntegration = true;

        plugins = {
          full-border = {
            package = pkgs.yaziPlugins.full-border;
            setup = true;
          };

          git = {
            package = pkgs.yaziPlugins.git;
            setup = true;
            settings.order = 1500;
          };

          chmod = pkgs.yaziPlugins.chmod;
          smart-enter = pkgs.yaziPlugins.smart-enter;
          smart-paste = pkgs.yaziPlugins.smart-paste;
        };

        settings.plugin.prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];

        keymap.mgr.prepend_keymap = [
          {
            on = "l";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = "p";
            run = "plugin smart-paste";
            desc = "Paste into the hovered directory or CWD";
          }
          {
            on = [
              "c"
              "m"
            ];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
        ];
      };
    };
}
