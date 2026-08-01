# Disk State — Debian Base VM

## Disk Location
/var/lib/libvirt/images/base/debian-base.qcow2

## Disk Type
- Format: qcow2
- Allocation: thin-provisioned

## Disk Policy
- Disk is NOT modified directly
- Any experiment must use:
  - snapshot
  - or cloned disk

## Recovery Strategy
If disk corruption occurs:
- Destroy VM
- Recreate from snapshot or base clone

