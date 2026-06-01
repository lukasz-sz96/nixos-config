_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      environment.systemPackages = with pkgs; [
        git
        vim
        wget
        curl
      ];
    };
}
