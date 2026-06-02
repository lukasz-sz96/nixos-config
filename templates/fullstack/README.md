# Fullstack Service

```sh
nix develop
cp .env.example .env
docker compose up -d
pnpm install
pnpm dev
```

Local services:

- PostgreSQL on `localhost:5432`
- Redis on `localhost:6379`
- Mailpit SMTP on `localhost:1025`
- Mailpit UI on `http://localhost:8025`
