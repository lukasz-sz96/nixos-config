# NixOS Workstation

Personal NixOS configuration for a Niri + Noctalia Wayland desktop and a modern web development workflow.

## Daily Commands

```sh
rebuild
update
nix fmt
nix flake check
```

`rebuild` and `update` are Fish aliases defined in `users/admin/programs/fish.nix`.

## Layout

```text
flake.nix                 flake inputs, formatter, checks, dev shell, host output
lib/mkHost.nix            shared host constructor
hosts/nixos/              machine entrypoint, hardware config, Disko template
profiles/nixos/base/      base OS, users, Nix, fonts, essential packages
profiles/nixos/boot/      systemd-boot and gated Secure Boot support
profiles/nixos/hardware/  audio, Bluetooth, graphics, networking, power, zram
profiles/nixos/storage/   Btrfs policy and gated impermanence support
profiles/nixos/security/  firewall, keyring, polkit, sops-nix, SSH defaults
profiles/nixos/desktop/   Wayland, SDDM, Niri, Noctalia system services
profiles/nixos/dev/       Git, containers, web development tools
users/admin/              Home Manager user config
secrets/                  sops-nix notes, no plaintext secrets
```

## Safe Rebuild

Normal rebuilds do not repartition disks, enroll Secure Boot keys, or enable an ephemeral root.

```sh
nix flake check --no-build
sudo nixos-rebuild switch --flake path:$HOME/nixos-config#nixos
```

## Prepared But Gated

- `hosts/nixos/disks.nix` is a Disko LUKS+Btrfs reinstall template. Use it only from an installer when you intentionally want to repartition.
- `workstation.secureBoot.enable` gates Lanzaboote. Leave it off until Secure Boot keys exist under `/etc/secureboot`.
- `workstation.impermanence.enable` gates impermanence. Leave it off until `/persist` exists and all required paths are declared.
- `sops-nix` is wired to the host SSH key by default, but no encrypted secrets are committed.

## Project Environments

Use `direnv` with `nix-direnv` for project-specific toolchains. A typical web project can use:

```sh
echo "use flake" > .envrc
direnv allow
```

Then define the project runtime in that project's `flake.nix`. Keep exact Node, package manager, database, and Playwright dependencies there when reproducibility matters.

For service-heavy projects, `devenv` is installed globally. A minimal project can start with:

```nix
{ pkgs, ... }:

{
  packages = [ pkgs.nodejs_24 ];

  services.postgres.enable = true;
  services.redis.enable = true;

  processes.web.exec = "pnpm dev";
}
```

## Git Notes

Local flake evaluation only sees files tracked by Git. After adding a new module, run:

```sh
git add path/to/new-file.nix
```

before `rebuild`, `nix flake check`, or `nix fmt` if the file is imported by the flake.
