# Cloud-Init Common

Direktori ini berisi konfigurasi Cloud-Init yang digunakan bersama oleh seluruh VM.

## Isi

* `user-data` → konfigurasi sistem (user, SSH key, package, sudo, timezone, service).
* `network-config` → konfigurasi jaringan standar (DHCP, DNS, routing, dan interface).

## Aturan

* Simpan konfigurasi yang berlaku untuk banyak VM di sini.
* Jangan menduplikasi file ke setiap instance jika isinya sama.
* Konfigurasi khusus VM dibuat di direktori `instances/<vm-name>/`.

