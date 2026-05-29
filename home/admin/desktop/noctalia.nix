{ config, ... }:

{
  xdg.configFile."noctalia/templates/starship-caelestia.toml".source =
    ../config/noctalia/templates/starship-caelestia.toml;

  programs.noctalia = {
    enable = true;

    settings.theme.templates = {
      enable_builtin_templates = true;
      builtin_ids = [
        "ghostty"
        "kitty"
        "niri"
      ];
      user.starship_caelestia = {
        input_path = "templates/starship-caelestia.toml";
        output_path = "${config.home.homeDirectory}/.config/starship.toml";
      };
    };
  };
}
