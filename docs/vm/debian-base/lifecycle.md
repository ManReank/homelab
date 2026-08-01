# VM Lifecycle — Debian Base

## Creation
Created once. Never reinstalled unless OS version changes.

## Usage
Used as base for:
- app VM
- infra VM
- experiment VM

## Update Policy
- No rolling update
- If baseline changes:
  - new snapshot
  - new documentation entry

## Decommission
Base VM is destroyed only if:
- Host OS is reinstalled
- Major architecture change
