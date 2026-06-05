_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      environment.systemPackages = with pkgs; [
        # JavaScript runtimes and package managers.
        nodejs_24
        corepack
        mise
        usage
        pnpm
        yarn
        bun
        deno
        typescript
        prettier
        vite

        # Local web app dependencies and service clients.
        docker-compose
        postgresql_17
        redis
        sqlite

        # API, TLS, and build tooling commonly needed by frontend/full-stack apps.
        xh
        mkcert
        openssl
        pkg-config

        # Language servers and formatters used by editors.
        biome
        eslint_d
        typescript-language-server
        tailwindcss-language-server
        vscode-langservers-extracted
        yaml-language-server
        dockerfile-language-server
      ];
    };
}
