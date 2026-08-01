# Debian Base VM

## Purpose
Base operating system image for all infra lab virtual machines.

This VM is treated as immutable baseline.

## Creation
- Host OS: Debian 12
- Hypervisor: KVM (libvirt system mode)
- Creation tool: virt-install

## Resources
- vCPU: 2
- Memory: 2 GB
- Disk: 20 GB (qcow2)

## Access
- Default user: infra
- SSH: enabled
- Console: serial

## Status
- Current state: active / shut down
- Snapshot available: yes

