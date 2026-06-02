# System

These notes cover the system-level pieces that are easy to forget when changing
the workstation.

## Boot

Boot modules live under `modules/nixos/boot/`.

- `systemd-boot.nix` enables systemd-boot and the CachyOS BORE kernel.
- `secure-boot.nix` defines `workstation.secureBoot.enable`, which switches the
  bootloader to Lanzaboote when enabled.

Do not enable Secure Boot until keys are enrolled and available under
`/etc/secureboot`.

## Storage

Storage modules live under `modules/nixos/storage/`.

- `btrfs.nix` adds compression, `noatime`, scrub, and fstrim.
- `impermanence.nix` is gated behind `workstation.impermanence.enable`.

The host hardware module expects:

```text
NIXBOOT  vfat mounted at /boot
NIXROOT  btrfs with @ mounted at / and @home mounted at /home
```

Use `nixos-rebuild boot` and reboot when changing mount options or filesystem
devices.

## Impermanence

Impermanence is prepared, not enabled by default.

Before enabling it, make sure `/persist` exists and that the persistence list
covers the state you actually use. Pay special attention to:

```text
/etc/NetworkManager/system-connections
/var/lib/bluetooth
/var/lib/docker
/var/lib/nixos
/var/log
~/.local/share/keyrings
~/.ssh
~/.mozilla
~/.local/state/noctalia
~/.cache/noctalia
~/Pictures/Wallpapers
```

The user directory list is shared between `admin` and `v` to avoid drift.

## Secrets

Secrets are wired through `sops-nix`, but no plaintext secrets belong in this
repo.

The default age key source is the host SSH key:

```nix
sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
```

That means a fresh machine needs its host SSH key in place before secrets can be
decrypted.

## Containers

Docker is enabled for workflow compatibility. The `docker` group is effectively
root-equivalent, so do not add users to it casually.

Podman is present as a disabled default. Enable it only when the workflow no
longer depends on Docker socket semantics.
