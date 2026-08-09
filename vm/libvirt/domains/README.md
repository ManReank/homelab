Libvirt Domains

Direktori ini menyimpan definisi domain/virtual machine libvirt dalam format XML.

Domain mendefinisikan resource dan perangkat VM seperti:

CPU
memory
disk
network interface
console
device lainnya

Domain dapat didaftarkan menggunakan:

sudo virsh define <file.xml>

Runtime state VM dikelola oleh libvirt dan tidak disimpan secara manual di direktori ini.
