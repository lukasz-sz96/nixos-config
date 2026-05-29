{
  programs.noctalia = {
    enable = true;

    settings.theme.templates = {
      enable_builtin_templates = true;
      builtin_ids = [
        "ghostty"
        "niri"
      ];
    };
  };
}
