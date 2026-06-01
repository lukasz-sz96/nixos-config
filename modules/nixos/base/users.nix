_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      users.users.admin = {
        isNormalUser = true;
        description = "admin";
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
        ];
        shell = pkgs.fish;
      };
      users.users.v = {
        isNormalUser = true;
        description = "v";
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
        ];
        shell = pkgs.fish;
      };

      programs.fish.enable = true;
    };
}
