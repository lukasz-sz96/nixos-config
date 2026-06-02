# Development Templates

The flake exposes small project starters for common local work. They are not
meant to be a framework. They give a new directory a sane shell, a few scripts,
and enough structure to start building.

## Use A Template

```sh
tnode app-name
cd app-name
nix develop
```

## Templates

- `tnode`: TypeScript Node.js service with pnpm, tsx, and Vitest.
- `tbun`: TypeScript Bun service with Bun test.
- `tpython`: Python 3.13 project with uv, pytest, ruff, and pyright.
- `trustproj`: Rust binary with cargo, rustfmt, and clippy.
- `tfulls`: Hono service with PostgreSQL, Redis, Mailpit, and Docker Compose.
- `tnext`: workspace for `create-next-app`.
- `tstart`: workspace for the TanStack CLI.
- `tservices`: Docker Compose recipes for PostgreSQL, Redis, Valkey, MySQL,
  and Mailpit.
