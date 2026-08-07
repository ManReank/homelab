# Lab Architecture

Host
│
├── Debian 13
├── Libvirt
├── Storage Pools
│
├── upstream
├── golden
├── vm
├── seed
│
└── Virtual Network
      │
      ├── default
      └── lab-net

VM

upstream image
        │
        ▼

golden image
        │
        ▼

linked clone
        │
        ▼

lab VM
