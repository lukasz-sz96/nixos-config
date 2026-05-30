# Secrets

This repo is prepared for `sops-nix`. Do not commit plaintext secrets.

The default configuration uses the host SSH key as an age identity:

```sh
sudo ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key
```

For a cleaner long-term setup, create a dedicated age key under `/var/lib/sops-nix/key.txt`, add its public recipient to `.sops.yaml`, then update `profiles/nixos/security/secrets.nix`.
