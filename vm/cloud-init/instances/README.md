# Cloud-init Instances

Direktori ini berisi konfigurasi spesifik setiap VM.

Setiap subdirektori hanya menyimpan `meta-data` yang mendefinisikan identitas instance, seperti:

- instance-id
- local-hostname

Konfigurasi umum (user, SSH key, paket dasar, dan network default) berada di:

../common/

Saat membuat VM baru:

1. Buat direktori baru.
2. Salin atau buat `meta-data`.
3. Generate seed ISO menggunakan `common/user-data`, `common/network-config`, dan `instances/<vm>/meta-data`.
