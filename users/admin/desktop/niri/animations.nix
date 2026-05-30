let
  windowOpenShader = ''
    vec4 open_color(vec3 coords_geo, vec3 size_geo) {
        float progress = niri_clamped_progress;
        float opacity = clamp(progress * 1.5, 0.0, 1.0);
        float slide_distance = 0.05;
        float y_offset = (1.0 - progress) * slide_distance;
        float scale = 0.95 + (0.05 * progress);
        vec3 coords = vec3((coords_geo.xy - vec2(0.5, 1.0)) / scale + vec2(0.5, 1.0), 1.0);
        coords.y -= y_offset;
        vec3 coords_tex = niri_geo_to_tex * coords;
        vec4 color = texture2D(niri_tex, coords_tex.st);
        return color * opacity;
    }
  '';

  windowCloseShader = ''
    vec4 close_color(vec3 coords_geo, vec3 size_geo) {
        float progress = 1.0 - niri_clamped_progress;
        float opacity = progress;
        float slide_distance = 0.05;
        float y_offset = (1.0 - progress) * slide_distance;
        float scale = 0.95 + (0.05 * progress);
        vec3 coords = vec3((coords_geo.xy - vec2(0.5, 1.0)) / scale + vec2(0.5, 1.0), 1.0);
        coords.y -= y_offset;
        vec3 coords_tex = niri_geo_to_tex * coords;
        vec4 color = texture2D(niri_tex, coords_tex.st);
        return color * opacity;
    }
  '';
in
{
  programs.niri.settings.animations = {
    workspace-switch.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1000;
      epsilon = 0.0001;
    };
    horizontal-view-movement.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1000;
      epsilon = 0.0001;
    };
    window-movement.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1000;
      epsilon = 0.0001;
    };
    window-resize.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1000;
      epsilon = 0.0001;
    };
    overview-open-close.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 850;
      epsilon = 0.0001;
    };
    window-open = {
      kind.easing = {
        duration-ms = 300;
        curve = "ease-out-cubic";
      };
      custom-shader = windowOpenShader;
    };
    window-close = {
      kind.easing = {
        duration-ms = 200;
        curve = "ease-out-quad";
      };
      custom-shader = windowCloseShader;
    };
    config-notification-open-close.kind.spring = {
      damping-ratio = 0.95;
      stiffness = 900;
      epsilon = 0.001;
    };
    screenshot-ui-open.kind.easing = {
      duration-ms = 200;
      curve = "ease-out-quad";
    };
  };
}
