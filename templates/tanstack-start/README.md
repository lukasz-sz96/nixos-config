# TanStack Start

Preferred usage from your workstation:

```sh
tstart my-tanstack-app
cd my-tanstack-app
nix develop
just bootstrap
pnpm dev
```

This creates a template directory first, then bootstraps the actual TanStack
Start app into that same active directory.

Manual usage:

```sh
nix flake init -t path:$HOME/nixos-config#tanstack-start
nix develop
just bootstrap
```

This runs:

```sh
pnpm dlx @tanstack/cli@latest create app --package-manager pnpm -y --no-git
```

There is also a Bun variant:

```sh
just bootstrap-bun
```
