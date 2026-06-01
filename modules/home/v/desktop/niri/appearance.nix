{ inputs, ... }:

{
  flake.modules.homeManager.v =
    { lib, ... }:

    let
      inherit (inputs.niri.lib.kdl)
        leaf
        plain
        ;
    in
    {
      programs.niri = {
        config = lib.mkOptionDefault (
          lib.mkAfter [
            (leaf "include" [
              { optional = true; }
              "noctalia.kdl"
            ])
            (plain "window-rule" [
              (plain "background-effect" [
                (leaf "blur" true)
                (leaf "xray" true)
                (leaf "noise" 0.05)
                (leaf "saturation" 2.4)
              ])
            ])
            (plain "layer-rule" [
              (leaf "match" { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel)$"; })
              (plain "background-effect" [
                (leaf "blur" true)
                (leaf "xray" false)
                (leaf "noise" 0.05)
                (leaf "saturation" 2.6)
              ])
            ])
            (plain "blur" [
              (leaf "passes" 3)
              (leaf "offset" 5.0)
              (leaf "noise" 0.04)
              (leaf "saturation" 1.8)
            ])
          ]
        );

        settings = {
          prefer-no-csd = true;

          debug = {
            honor-xdg-activation-with-invalid-serial = [ ];
          };
        };
      };
    };
}
