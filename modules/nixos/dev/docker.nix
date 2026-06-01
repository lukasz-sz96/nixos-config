_:

{
  flake.modules.nixos.workstation = {
    # Membership in the docker group is root-equivalent. Keep Docker for current
    # workflow compatibility; prefer project-local services and consider Podman
    # once the workflow no longer depends on Docker socket semantics.
    virtualisation.docker.enable = true;
  };
}
