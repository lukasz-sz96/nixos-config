# Development Templates

The flake exposes small project starters for common local work. They are not
meant to be a framework. They give a new directory a sane shell, a few scripts,
and enough structure to start building.

## Use A Template

```sh
mkdir my-project
cd my-project
nix flake init -t path:$HOME/nixos-config#node
nix develop
```

For templates that generate a framework app, prefer the Fish helpers:

```sh
tnext my-next-app
tstart my-tanstack-app
```

Those create the target directory first. Then run `just bootstrap` inside it so
the framework files land in the active directory instead of a nested folder.

## Templates

- `node`: TypeScript Node.js service with pnpm, tsx, and Vitest.
- `bun`: TypeScript Bun service with Bun test.
- `python`: Python 3.13 project with uv, pytest, ruff, and pyright.
- `rust`: Rust binary with cargo, rustfmt, and clippy.
- `fullstack`: Hono service with PostgreSQL, Redis, Mailpit, and Docker Compose.
- `nextjs`: workspace for `create-next-app`.
- `tanstack-start`: workspace for the TanStack CLI.
- `local-services`: Docker Compose recipes for PostgreSQL, Redis, Valkey, MySQL,
  and Mailpit.

## Examples

Full-stack service:

```sh
nix flake init -t path:$HOME/nixos-config#fullstack
nix develop
cp .env.example .env
docker compose up -d
pnpm install
pnpm dev
```

Next.js:

```sh
tnext my-next-app
cd my-next-app
nix develop
just bootstrap
pnpm dev
```

TanStack Start:

```sh
tstart my-tanstack-app
cd my-tanstack-app
nix develop
just bootstrap
pnpm dev
```

Local services only:

```sh
nix flake new -t path:$HOME/nixos-config#local-services -- services
cd services
docker compose up -d postgres redis mailpit
```
