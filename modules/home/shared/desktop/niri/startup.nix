_:

{
  flake.modules.homeManager.shared = {
    programs.niri.settings.spawn-at-startup = [
      { command = [ "noctalia" ]; }
    ];
  };
}
