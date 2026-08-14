# SSH

SSH (Secure Shell) is a protocol used for secure remote access and communication between systems.

In this homelab, SSH is used for two different purposes:

1. Remote administration of virtual machines.
2. Authentication between the development VM and external services such as GitHub.

## SSH Roles

A system can act as either an SSH client or an SSH server.

```text
SSH Client
    |
    | SSH connection
    v
SSH Server
