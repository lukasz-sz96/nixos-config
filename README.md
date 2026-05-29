# NixOS Workstation

Personal NixOS configuration for a Niri + Noctalia Wayland desktop and a modern web development workflow.

## Daily Commands

```sh
rebuild
update
nix fmt
nix flake check
```

`rebuild` and `update` are Fish aliases defined in `home/admin/programs/fish.nix`.

## Layout

```text
flake.nix                 flake inputs, formatter, checks, dev shell, host output
hosts/nixos/              machine entrypoint and hardware config
modules/core/             base OS, users, Nix, fonts, hardware
modules/desktop/          Wayland, Niri, Noctalia system services
modules/dev/              Git, Docker, web development tools
modules/security/         local workstation security and secret service
home/admin/               Home Manager user config
```

## Project Environments

Use `direnv` with `nix-direnv` for project-specific toolchains. A typical web project can use:

```sh
echo "use flake" > .envrc
direnv allow
```

Then define the project runtime in that project's `flake.nix`. Keep exact Node, package manager, database, and Playwright dependencies there when reproducibility matters.

## Git Notes

Local flake evaluation only sees files tracked by Git. After adding a new module, run:

```sh
git add path/to/new-file.nix
```

before `rebuild`, `nix flake check`, or `nix fmt` if the file is imported by the flake.
