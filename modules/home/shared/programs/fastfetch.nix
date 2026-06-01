_:

{
  flake.modules.homeManager.shared = {
    xdg.configFile."fastfetch/config.jsonc".text = ''
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
          "type": "small",
          "padding": {
            "top": 1,
            "right": 2
          }
        },
        "display": {
          "separator": "  "
        },
        "modules": [
          "break",
          {
            "type": "custom",
            "key": "{#36}nixos workstation"
          },
          "separator",
          {
            "type": "os",
            "key": "os      ",
            "keyColor": "blue"
          },
          {
            "type": "kernel",
            "key": "kernel  ",
            "keyColor": "blue"
          },
          {
            "type": "uptime",
            "key": "uptime  ",
            "keyColor": "green",
            "format": "{?days}{days}d {?}{hours}h {minutes}m"
          },
          {
            "type": "packages",
            "key": "pkgs    ",
            "keyColor": "green"
          },
          {
            "type": "shell",
            "key": "shell   ",
            "keyColor": "yellow"
          },
          {
            "type": "wm",
            "key": "wm      ",
            "keyColor": "yellow"
          },
          {
            "type": "terminal",
            "key": "term    ",
            "keyColor": "magenta"
          },
          {
            "type": "terminalfont",
            "key": "font    ",
            "keyColor": "magenta"
          },
          {
            "type": "cpu",
            "key": "cpu     ",
            "keyColor": "cyan"
          },
          {
            "type": "gpu",
            "key": "gpu     ",
            "keyColor": "cyan"
          },
          {
            "type": "memory",
            "key": "memory  ",
            "keyColor": "red"
          },
          {
            "type": "disk",
            "key": "disk    ",
            "keyColor": "red",
            "folders": "/"
          },
          {
            "type": "battery",
            "key": "battery ",
            "keyColor": "blue"
          },
          "break",
          "colors"
        ]
      }
    '';
  };
}
