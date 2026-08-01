# Infra Lab

## Objective
Membangun lab infra lokal untuk simulasi environment backend & DevOps
dengan pendekatan production-like dan terdokumentasi.

## Purpose
## Purpose
Lab ini digunakan untuk membangun dan menguji sistem infrastruktur
yang dapat direproduksi, dianalisis kegagalannya, dan didokumentasikan
sebagai simulasi environment production.

VM dan container dapat dihancurkan, tetapi konfigurasi, keputusan,
dan pembelajaran tidak dianggap disposable.

## Rules
- Host system tidak disentuh untuk eksperimen
- Semua eksperimen diisolasi (VM / container)
- Tidak reinstall host
- Semua perubahan dicatat

## Tooling Baseline
- Debian 12 (host)
- KVM + libvirt
- Docker + docker-compose
