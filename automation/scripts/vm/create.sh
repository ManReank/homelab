#!/usr/bin/env bash
set -euo pipefail

CONFIG="$HOME/lab/automation/config/vm/${1:?VM config required}.conf"

source "$CONFIG"

command -v virsh >/dev/null
command -v qemu-img >/dev/null
command -v cloud-localds >/dev/null

[[ -f "$BASE_IMAGE" ]] || {
    echo "Base image not found: $BASE_IMAGE"
    exit 1
}

sudo virsh net-info "$NETWORK" >/dev/null 2>&1 || {
    echo "Network not found: $NETWORK"
    exit 1
}

if sudo virsh dominfo "$VM_NAME" >/dev/null 2>&1; then
    echo "VM already exists: $VM_NAME"
    exit 1
fi

echo "Configuration validation successful."

if [[ -e "$VM_DISK" ]]; then
    echo "VM disk already exists: $VM_DISK"
    exit 1
fi

    
[[ -d "$CLOUD_INIT_INSTANCE" ]] || {
    echo "Cloud-init instance not found: $CLOUD_INIT_INSTANCE"
    exit 1
}

[[ -f "$CLOUD_INIT_INSTANCE/meta-data" ]] || {
    echo "meta-data not found"
    exit 1
}

mkdir -p "$(dirname "$SEED_ISO")"

cloud-localds \
    --network-config="$HOME/lab/vm/cloud-init/common/network-config" \
    "$SEED_ISO" \
    "$HOME/lab/vm/cloud-init/common/user-data" \
    "$CLOUD_INIT_INSTANCE/meta-data"
    
mkdir -p "$(dirname "$VM_DISK")"

qemu-img create \
    -f qcow2 \
    -F qcow2 \
    -b "$BASE_IMAGE" \
    "$VM_DISK"

sudo virt-install \
    --name "$VM_NAME" \
    --memory "$MEMORY_MB" \
    --vcpus "$VCPUS" \
    --cpu host \
    --import \
    --osinfo debian11 \
    --disk "path=$VM_DISK,bus=virtio" \
    --disk "path=$SEED_ISO,device=cdrom" \
    --network "network=$NETWORK,model=virtio" \
    --graphics none \
    --console pty,target_type=serial \
    --noautoconsole
    
   

