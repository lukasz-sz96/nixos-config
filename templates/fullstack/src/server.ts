import { serve } from "@hono/node-server";
import { Hono } from "hono";
import { z } from "zod";

const envSchema = z.object({
  PORT: z.coerce.number().default(3000),
  DATABASE_URL: z.string().default("postgres://app:app@localhost:5432/app"),
  REDIS_URL: z.string().default("redis://localhost:6379"),
});

const env = envSchema.parse(process.env);
const app = new Hono();

app.get("/", (c) => c.json({ ok: true, service: "fullstack-service" }));
app.get("/health", (c) =>
  c.json({
    ok: true,
    databaseUrlConfigured: Boolean(env.DATABASE_URL),
    redisUrlConfigured: Boolean(env.REDIS_URL),
  })
);

serve(
  {
    fetch: app.fetch,
    port: env.PORT,
  },
  (info) => {
    console.log(`server listening on http://localhost:${info.port}`);
  }
);
