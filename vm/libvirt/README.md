Libvirt

Direktori ini menyimpan konfigurasi infrastructure untuk libvirt.

libvirt/
├── domains/    # Definisi VM
├── networks/   # Definisi virtual network
└── pools/      # Definisi storage pool

Libvirt bertanggung jawab terhadap lifecycle dan resource virtual machine.

File XML di direktori ini digunakan sebagai source configuration dan dapat diterapkan menggunakan virsh.
