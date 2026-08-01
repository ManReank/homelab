# Snapshot Strategy — Debian Base VM

## Snapshot Name
base-clean

## Description
Fresh Debian installation with minimal infra tools.

## Creation Time
YYYY-MM-DD HH:MM

## Included State
- OS installed
- Base packages updated
- SSH enabled
- No application installed

## Usage Rules
- NEVER work directly on this snapshot
- Always clone or revert before modification

## Restore Command
```bash
virsh snapshot-revert debian-base base-clean

