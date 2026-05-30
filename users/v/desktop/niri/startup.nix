{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "noctalia" ]; }
    { command = [ "xwayland-satellite" ]; }
  ];
}
