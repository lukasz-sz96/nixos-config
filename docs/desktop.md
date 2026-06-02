# Desktop

This desktop is built around Niri and Noctalia. Niri owns the compositor,
keybindings, layout, and window rules. Noctalia owns the shell UI: bar,
launcher, notifications, wallpaper, clipboard, OSD, and session actions.

## Niri Modules

The Home Manager Niri config is split by what you are likely to change:

```text
modules/home/shared/desktop/niri/appearance.nix  raw KDL for blur and Noctalia layers
modules/home/shared/desktop/niri/animations.nix  animation springs and shaders
modules/home/shared/desktop/niri/bindings.nix    keyboard and media bindings
modules/home/shared/desktop/niri/layout.nix      input, gaps, and column widths
modules/home/shared/desktop/niri/rules.nix       app matching and window behavior
modules/home/shared/desktop/niri/startup.nix     startup commands
```

Keep generated binding helpers simple. If a shortcut is a one-off, write it as a
one-off. If it is part of a repeated family, add it through the small helpers in
`bindings.nix`.

## Noctalia

Declarative Noctalia settings live in
`modules/home/shared/desktop/noctalia.nix`.

Runtime state can still be written by the shell UI:

```text
~/.local/state/noctalia/settings.toml
~/.cache/noctalia/wallpapers.json
~/Pictures/Wallpapers
```

Persist those paths before enabling impermanence.

Noctalia starts from Niri:

```nix
programs.niri.settings.spawn-at-startup = [
  { command = [ "noctalia" ]; }
];
```

That is intentional. A single startup path avoids duplicate shell instances.

## SDDM

SDDM is configured in `modules/nixos/desktop/niri-noctalia/sddm.nix`.

The setup uses:

- SDDM on Wayland with KWin as the greeter compositor.
- Qylock themes from the `qylock` flake input.
- Bibata cursor settings matched to the user session.
- Extra Qt and GStreamer packages needed by the theme.

If the greeter cursor changes size or falls back to a default theme, check both
the SDDM module and `modules/home/shared/desktop/cursor.nix`.

## Portals

Portal config lives in `modules/nixos/desktop/niri-noctalia/wayland.nix`.

The current setup prefers GNOME/GTK portals under Niri and uses GTK for file
choosers and access dialogs. Keep this boring unless an app has a specific
portal problem.

## Window Rules

Window rules are in `modules/home/shared/desktop/niri/rules.nix`.

The rules only set behavior that is useful across sessions: default widths,
floating dialogs, media windows, OBS, game windows, and VRR for games. They do
not route apps to named workspaces, because this setup relies on Niri's dynamic
workspace model.
