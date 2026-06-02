# Development Workflows

These notes cover the habits this workstation is set up for. Project-specific
tool versions still belong inside each project.

## Project Shells

Use `mise` for everyday runtime pins:

```sh
mise use node@24
mise use bun@latest
mise use python@3.13
```

Use `direnv` when a project has a Nix shell:

```sh
echo "use flake" > .envrc
direnv allow
```

The shared Home Manager profile enables `direnv`, `nix-direnv`, `mise`, and the
Fish shell integration needed for them to load automatically.

## Local Services

For one-off databases and mail testing, use the `local-services` template:

```sh
nix flake new -t path:$HOME/nixos-config#local-services -- services
cd services
docker compose up -d postgres redis mailpit
```

Useful defaults:

```text
PostgreSQL  localhost:5432
Redis       localhost:6379
Valkey      localhost:6379 when started instead of Redis
MySQL       localhost:3306
Mailpit     SMTP localhost:1025, UI http://localhost:8025
```

## Ports

List local listeners:

```sh
ports
```

Forward remote ports over SSH:

```sh
fip my-server 3000 5432
lip
dip my-server 3000 5432
```

`fip` creates a control socket under `$XDG_RUNTIME_DIR`, `lip` lists active
forward sockets, and `dip` closes them.

## Quick Utilities

```sh
mkcd workbench
serve 8000
extract archive.tar.zst
compress ./folder
```

Niri also has bindings for a few workstation scripts:

- `Mod+Ctrl+Print`: OCR a selected region and copy the text.
- `Mod+Ctrl+Alt+T`: show a notification with the current date and time.
- `Mod+Ctrl+R`: schedule a reminder through a small prompt.

## Repo Checks

Inside this repo:

```sh
just check
just dry-build
just diff
```

In any shell:

```sh
check
drybuild
diff
doctor
```
