_:

{
  flake.templates = {
    node = {
      path = ../../templates/node;
      description = "TypeScript Node.js service with pnpm, tsx, Vitest, and a Nix dev shell";
    };

    bun = {
      path = ../../templates/bun;
      description = "TypeScript Bun service with Bun test and a Nix dev shell";
    };

    python = {
      path = ../../templates/python;
      description = "Python project with uv, pytest, ruff, pyright, and a Nix dev shell";
    };

    rust = {
      path = ../../templates/rust;
      description = "Rust binary project with cargo, rustfmt, clippy, and a Nix dev shell";
    };

    fullstack = {
      path = ../../templates/fullstack;
      description = "TypeScript full-stack starter with Hono, PostgreSQL, Redis, Mailpit, and Docker Compose";
    };

    nextjs = {
      path = ../../templates/nextjs;
      description = "Next.js generator workspace with Nix dev shell and official create-next-app bootstrap command";
    };

    tanstack-start = {
      path = ../../templates/tanstack-start;
      description = "TanStack Start generator workspace with Nix dev shell and official TanStack bootstrap commands";
    };

    local-services = {
      path = ../../templates/local-services;
      description = "Docker Compose recipes for PostgreSQL, Redis, MySQL, Valkey, and Mailpit";
    };
  };
}
