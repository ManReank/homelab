# Ansible Automation

Ansible configuration for provisioning and managing infrastructure in the homelab environment.

## Purpose

This directory contains Ansible automation used to configure and manage virtual machines and other infrastructure resources in the lab.

The goal is to make server configuration:

* reproducible
* idempotent
* documented
* version-controlled

## Architecture

```text
Golden Image
      |
      v
Cloud-init
      |
      v
SSH Ready VM
      |
      v
Ansible
      |
      +--> Base OS configuration
      +--> Development tools
      +--> Docker
      +--> Security configuration
      |
      v
Ready Server
```

## Directory Structure

```text
ansible/
├── ansible.cfg
├── inventory/
├── playbooks/
├── roles/
├── group_vars/
├── host_vars/
└── files/
```

| Directory / File | Purpose                                                                 |
| ---------------- | ----------------------------------------------------------------------- |
| `ansible.cfg`    | Project-level configuration for Ansible.                                |
| `inventory/`     | Defines the hosts and groups managed by Ansible.                        |
| `playbooks/`     | Contains automation workflows that define what Ansible should do.       |
| `roles/`         | Contains reusable configuration components organized by responsibility. |
| `group_vars/`    | Stores variables shared by groups of hosts.                             |
| `host_vars/`     | Stores variables specific to individual hosts.                          |
| `files/`         | Contains static files that may be deployed to managed hosts.            |

For more detailed information, see the `README.md` inside each directory.

## Execution Model

Ansible uses SSH to manage remote hosts.

```text
Control Node
    |
    | SSH
    v
Managed Host
```

The homelab host acts as the **Ansible Control Node**.

VMs and other infrastructure resources act as **Managed Hosts**.

## Current Targets

* Development server
* Future staging infrastructure
* Future production VPS

## Infrastructure Flow

```text
Golden Image
     |
     v
Create VM
     |
     v
Cloud-init
     |
     v
SSH Ready
     |
     v
Ansible
     |
     v
Configured Server
```

## Principle

Infrastructure should be reproducible.

If a VM is destroyed, its configuration should be recoverable through automation rather than undocumented manual configuration.

## Learning Approach

This Ansible project is also a learning environment.

Features and abstractions are introduced gradually based on actual infrastructure requirements instead of adopting unnecessary complexity from the beginning.

