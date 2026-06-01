# NixOS Workstation

Personal NixOS configuration for a Niri + Noctalia Wayland desktop and a modern web development workflow.

## Daily Commands

```sh
rebuild
update
nix fmt
nix flake check
```

`rebuild` and `update` are Fish aliases defined in `modules/home/shared/programs/fish.nix`.

## Layout

```text
flake.nix                 flake inputs, formatter, checks, dev shell, host output
modules/                  dendritic flake-parts module tree
modules/flake/            formatter, checks, dev shell, common flake settings
modules/hosts/            NixOS host outputs and host-specific hardware modules
modules/nixos/            workstation NixOS feature modules
modules/home/shared/      shared Home Manager desktop, app, shell, editor, and theme profile
modules/home/admin/       admin account module importing the shared profile
modules/home/v/           v test-user account module importing the shared profile
secrets/                  sops-nix notes, no plaintext secrets
```

## Install

The host config uses filesystem labels instead of UUIDs:

```text
NIXBOOT  /boot, vfat
NIXROOT  / and /home, btrfs subvolumes @ and @home
```

For a fresh install, create the labels while formatting:

```sh
mkfs.vfat -n NIXBOOT <efi-partition>
mkfs.btrfs -L NIXROOT <root-partition>

mount /dev/disk/by-label/NIXROOT /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount /mnt
```

For an existing install with the same layout, set the labels once:

```sh
sudo btrfs filesystem label / NIXROOT
sudo fatlabel "$(findmnt -no SOURCE /boot)" NIXBOOT
lsblk -f
```

Mount the install target:

```sh
mount -o subvol=@,compress=zstd,noatime /dev/disk/by-label/NIXROOT /mnt
mkdir -p /mnt/home /mnt/boot
mount -o subvol=@home,compress=zstd,noatime /dev/disk/by-label/NIXROOT /mnt/home
mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

Then clone this repo under `/mnt`, edit anything local such as usernames or
host name, and run:

```sh
sudo nixos-install --flake /mnt/path/to/nixos-config#nixos
```

`modules/hosts/nixos/hardware.nix` is intentionally generic. If a machine needs local
kernel modules, swap, LUKS, or different labels, patch that file in a private
fork or local branch rather than committing disk UUIDs to the public config.

## Safe Rebuild

Normal rebuilds do not repartition disks, enroll Secure Boot keys, or enable an ephemeral root.

```sh
nix flake check --no-build
sudo nixos-rebuild switch --flake path:$HOME/nixos-config#nixos
```

When changing filesystem devices, labels, or mount options, use `boot` first so
active mounts like `/home` are not restarted under your running session:

```sh
sudo nixos-rebuild boot --flake path:$HOME/nixos-config#nixos
sudo reboot
```

## Prepared But Gated

- `workstation.secureBoot.enable` gates Lanzaboote. Leave it off until Secure Boot keys exist under `/etc/secureboot`.
- `workstation.impermanence.enable` gates impermanence. Leave it off until `/persist` exists and all required paths are declared.
- `sops-nix` is wired to the host SSH key by default, but no encrypted secrets are committed.

## Project Environments

Use `mise` for per-project language/runtime versions:

```sh
mise use node@24
mise use bun@latest
mise use python@3.13
```

This writes a local `.mise.toml`.

Use `direnv` with `nix-direnv` for Nix project shells:

```sh
echo "use flake" > .envrc
direnv allow
```

## Git Notes

The flake uses the dendritic pattern: `flake.nix` is the entry point, and each
Nix file under `modules/` is a flake-parts module imported automatically by
`import-tree`. Feature modules merge into shared lower-level modules such as
`flake.modules.nixos.workstation`, `flake.modules.homeManager.shared`, and the per-user account modules.

When evaluating with `.#...`, local flake evaluation only sees files tracked by
Git. After adding a new module, run:

```sh
git add path/to/new-file.nix
```

before `rebuild`, `nix flake check`, or `nix fmt` if the file is imported by the flake.
For quick local checks without staging, use an explicit path flake reference:

```sh
nix flake check --no-build path:$HOME/nixos-config
```
