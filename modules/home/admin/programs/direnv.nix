_:

{
  flake.modules.homeManager.admin = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      config = {
        global = {
          hide_env_diff = true;
          warn_timeout = "1m";
        };
      };
    };
  };
}
