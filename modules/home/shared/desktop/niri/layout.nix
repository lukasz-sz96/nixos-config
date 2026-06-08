{ inputs, ... }:

{
  flake.modules.homeManager.shared =
    { lib, ... }:

    let
      inherit (inputs.niri.lib.kdl)
        flag
        leaf
        node
        plain
        ;

      defaultColumnWidth =
        width:
        plain "default-column-width" [
          (leaf (builtins.head (builtins.attrNames width)) (builtins.head (builtins.attrValues width)))
        ];

      struts =
        size:
        plain "struts" [
          (leaf "left" size)
          (leaf "right" size)
          (leaf "top" size)
          (leaf "bottom" size)
        ];

      workspaceLayout = name: layout: node "workspace" name [ (plain "layout" layout) ];
    in
    {
      programs.niri = {
        config = lib.mkOptionDefault (
          lib.mkBefore [
            (workspaceLayout "browser" [
              (leaf "gaps" 24)
              (defaultColumnWidth { proportion = 0.66667; })
            ])
            (workspaceLayout "code" [
              (leaf "gaps" 18)
              (defaultColumnWidth { proportion = 0.75; })
              (leaf "center-focused-column" "always")
              (flag "always-center-single-column")
            ])
            (workspaceLayout "chat" [
              (leaf "gaps" 32)
              (defaultColumnWidth { proportion = 0.33333; })
              (leaf "center-focused-column" "always")
              (flag "always-center-single-column")
            ])
            (workspaceLayout "gaming" [
              (leaf "gaps" 0)
              (plain "border" [ (flag "off") ])
            ])
            (workspaceLayout "aesthetic" [
              (leaf "gaps" 40)
              (struts 96)
              (defaultColumnWidth { proportion = 0.66667; })
              (leaf "center-focused-column" "always")
              (flag "always-center-single-column")
            ])
          ]
        );

        settings = {
          input = {
            keyboard.xkb.layout = "pl";
            touchpad = {
              tap = true;
              natural-scroll = true;
              disabled-on-external-mouse = true;
            };
          };

          layout = {
            gaps = 28;
            center-focused-column = "never";
            focus-ring.enable = true;
            border.enable = false;
            preset-column-widths = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
              { proportion = 1.0; }
            ];
            default-column-width.proportion = 0.5;
          };
        };
      };
    };
}
