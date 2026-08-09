VM Images

Direktori ini menyimpan image yang digunakan oleh virtual machine.

images/
├── upstream/   # Image asli dari provider/distribusi
├── golden/     # Golden image yang sudah dipersiapkan
├── seed/       # Cloud-init seed ISO
└── vm/         # Disk VM hasil provisioning/clone
Aturan
upstream/ tidak dimodifikasi.
golden/ menjadi sumber pembuatan VM baru.
seed/ berisi konfigurasi instance Cloud-init.
vm/ berisi disk VM yang sedang digunakan.

Image berukuran besar tidak disimpan di repository Git.
