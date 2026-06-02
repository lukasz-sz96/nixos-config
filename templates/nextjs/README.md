# Next.js

Preferred usage from your workstation:

```sh
tnext my-next-app
cd my-next-app
nix develop
just bootstrap
pnpm dev
```

This creates a template directory first, then bootstraps the actual Next.js app
into that same active directory.

Manual usage:

```sh
nix flake init -t path:$HOME/nixos-config#nextjs
nix develop
just bootstrap
pnpm dev
```

The bootstrap command uses `create-next-app` with TypeScript, Tailwind, ESLint,
the App Router, `src/`, and `@/*` imports.
