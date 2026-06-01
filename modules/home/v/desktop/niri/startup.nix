_:

{
  flake.modules.homeManager.v = {
    programs.niri.settings.spawn-at-startup = [
      { command = [ "noctalia" ]; }
    ];
  };
}
