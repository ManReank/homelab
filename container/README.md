# Container

Direktori ini menyimpan konfigurasi dan definisi workload container
yang dijalankan pada VM lab.

Container tidak dijalankan langsung pada host. Docker Engine berjalan
di dalam VM yang disediakan oleh lab.

## Tujuan

- Menyimpan Docker Compose dan konfigurasi container.
- Membuat deployment container reproducible.
- Memisahkan konfigurasi workload dari VM dan host.
- Menjadi dasar eksperimen Docker, Compose, networking, dan service deployment.

## Struktur

Konfigurasi container akan dikelompokkan berdasarkan workload atau service.

Contoh:

```text
container/
├── compose/
│   └── <workload>/
│       └── compose.yaml
└── configs/
    └── <service>/
