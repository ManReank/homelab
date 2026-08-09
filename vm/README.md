Virtual Machines

Direktori ini menyimpan konfigurasi dan resource yang berkaitan dengan virtual machine.

vm/
├── cloud-init/   # Provisioning awal VM
└── libvirt/      # Definisi infrastructure libvirt

VM disk dan image tidak disimpan di direktori ini. Disk berada di images/vm/.

Alur umum provisioning:

upstream image
      ↓
golden image
      ↓
cloud-init seed
      ↓
libvirt VM
      ↓
SSH
      ↓
configuration / automation
