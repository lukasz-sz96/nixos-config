{ inputs, ... }:

{
  flake.modules.nixos.workstation =
    {
      config,
      lib,
      ...
    }:

    {
      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];

      options.workstation.impermanence.enable = lib.mkEnableOption "ephemeral root with explicit persistence";

      config = lib.mkIf config.workstation.impermanence.enable {
        environment.persistence."/persist" = {
          hideMounts = true;
          directories = [
            "/etc/NetworkManager/system-connections"
            "/var/lib/bluetooth"
            "/var/lib/docker"
            "/var/lib/fprint"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/var/log"
          ];
          files = [
            "/etc/machine-id"
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
          ];
          users.admin = {
            directories = [
              ".cache/direnv"
              ".config/gh"
              ".config/sops"
              ".local/share/direnv"
              ".local/share/fish"
              ".local/share/keyrings"
              ".mozilla"
              ".ssh"
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Projects"
              "Videos"
            ];
          };
          users.v = {
            directories = [
              ".cache/direnv"
              ".config/gh"
              ".config/sops"
              ".local/share/direnv"
              ".local/share/fish"
              ".local/share/keyrings"
              ".mozilla"
              ".ssh"
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Projects"
              "Videos"
            ];
          };
        };
      };
    };
}
