_:

{
  flake.modules.nixos.workstation =
    { pkgs, ... }:

    {
      environment.systemPackages = with pkgs; [
        # Rust compiler, package manager, formatter, linter, and optional
        # toolchain manager for projects that need a different channel.
        rustc
        cargo
        rustfmt
        clippy
        rustup

        # Editor support and common cargo subcommands.
        rust-analyzer
        cargo-audit
        cargo-edit
        cargo-nextest
        cargo-watch
        bacon

        # Native dependencies commonly needed when compiling Rust crates.
        gcc
        openssl
        pkg-config
      ];
    };
}
