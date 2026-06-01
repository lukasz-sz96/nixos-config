_:

{
  flake.modules.homeManager.shared = {
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
