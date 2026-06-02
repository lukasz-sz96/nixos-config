_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    let
      normalUser = name: {
        isNormalUser = true;
        description = name;
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
        ];
        shell = pkgs.fish;
      };
    in
    {
      users.users = {
        admin = normalUser "admin";
        v = normalUser "v";
      };

      programs.fish.enable = true;
    };
}
