# Docker

## Mental Model

Docker Engine adalah runtime yang mengelola image, container, network, dan volume.

Dockerfile
    │ docker build
    ▼
  Image
    │ docker run / docker compose up
    ▼
Container
    ├── writable filesystem
    ├── network
    └── mount → volume / bind mount

## Image

Image adalah immutable artifact/template yang digunakan untuk membuat container.

Dockerfile → docker build → Image → Container

Command utama:

docker image ls
docker image inspect IMAGE
docker history IMAGE
docker rmi IMAGE

## Container

Container adalah instance dari image dan bersifat disposable.

docker ps
docker ps -a
docker logs CONTAINER
docker inspect CONTAINER
docker exec -it CONTAINER sh

Lifecycle:

docker stop → container berhenti, masih ada
docker start → menjalankan kembali container
docker rm → container dihapus

Writable layer container ikut hilang ketika container dihapus. Karena itu container tidak boleh dijadikan tempat penyimpanan data persisten.

## Dockerfile

Dockerfile mendefinisikan bagaimana image dibangun.

Instruksi utama:

FROM       → base image
RUN        → eksekusi saat build
COPY       → file dari build context ke image
WORKDIR    → working directory
CMD        → default command saat runtime
ENTRYPOINT → executable utama container

Memory hook:

RUN → build time
CMD → runtime

## Build Context

Saat menjalankan:

docker build .

`.` menjadi build context. Docker hanya dapat menggunakan file yang berada di dalam context tersebut.

Gunakan `.dockerignore` untuk mengecualikan file yang tidak diperlukan, misalnya:

.git
node_modules
.env
*.log

Secret tidak boleh dimasukkan ke image.

## Image Layer dan Cache

Dockerfile menghasilkan filesystem layers. Docker dapat menggunakan kembali layer yang tidak berubah melalui build cache.

Prinsip penyusunan Dockerfile:

dependency yang jarang berubah
        ↓
source code yang sering berubah

Tujuannya menghindari pekerjaan build yang tidak perlu ketika hanya source code berubah.

## Storage

Container memiliki writable layer sendiri. Data di layer tersebut bersifat disposable.

### Volume

Volume adalah storage yang lifecycle-nya terpisah dari container dan dikelola Docker.

docker volume create DATA
docker volume ls
docker volume inspect DATA

Mount:

-v DATA:/data

Volume cocok untuk database dan application state yang harus tetap ada ketika container dihancurkan dan dibuat ulang.

### Bind Mount

Bind mount memasangkan filesystem host langsung ke container.

-v /host/path:/container/path

Cocok terutama untuk development dan source code.

Volume      → Docker-managed storage
Bind mount  → host filesystem

## Networking

Container memiliki network namespace sendiri. Docker Network memungkinkan container berkomunikasi satu sama lain.

docker network ls
docker network create NETWORK
docker network inspect NETWORK

Container pada network yang sama dapat berkomunikasi menggunakan nama container/service sebagai hostname tanpa hardcode IP.

app → db:5432

`localhost` di dalam container berarti container itu sendiri.

app → localhost = app sendiri
app → db       = container db

### Port Publishing

-p HOST_PORT:CONTAINER_PORT

Contoh:

-p 8080:8000

Host :8080
    ↓
Container :8000

Port publishing diperlukan untuk akses dari host/external network. Container-to-container pada Docker Network tidak membutuhkan `-p`.

## Docker Compose

Compose digunakan untuk mendefinisikan dan mengelola application stack yang terdiri dari beberapa container, network, volume, dan konfigurasi.

compose.yaml
     ↓
Docker Engine
     ├── containers
     ├── networks
     └── volumes

Compose bukan pengganti Docker Engine.

### Services

Contoh:

services:
  web:
    image: python:3.12-alpine

  postgres:
    image: postgres:17-alpine

`web` dan `postgres` adalah service names. Service name dapat digunakan sebagai hostname dalam network Compose.

web → postgres:5432

### image vs build

`image:` menggunakan image yang sudah tersedia.

`build:` meminta Compose membangun image dari Dockerfile dan build context.

Dockerfile
    ↓
build
    ↓
Image
    ↓
Container

### Common Commands

docker compose up -d
docker compose ps
docker compose logs
docker compose logs -f SERVICE
docker compose exec SERVICE sh
docker compose config
docker compose down

`docker compose down` menghapus container dan network stack, tetapi volume tidak dihapus secara default.

`docker compose down -v` juga menghapus volume yang dikelola Compose.

Jangan menggunakan `-v` sembarangan karena dapat menghapus persistent database data.

## Runtime vs Persistent Data

Bedakan resource berdasarkan lifecycle:

Application code
    → Image

Runtime configuration
    → Environment / configuration

Secrets
    → Secret management

Persistent data
    → Volume / external storage

Disposable runtime state
    → Container filesystem

Prinsip:

Jika data harus survive ketika container dihancurkan, jangan menyimpannya hanya di writable layer container.

## Development vs Production

Development dapat menggunakan bind mount untuk mempercepat feedback loop:

Host source
    ↓ bind mount
Container

Production/runtime sebaiknya menjalankan immutable image:

Source
   ↓
CI build + test
   ↓
Image
   ↓
GHCR
   ↓
Runtime

Runtime server tidak seharusnya melakukan build aplikasi secara manual.

## Infrastructure Boundary

Infrastructure lab dan application repository memiliki tanggung jawab berbeda.

~/lab
├── automation
├── vm
├── network
├── images
└── docs

application repository
├── source code
├── Dockerfile
├── compose.yaml
└── application docs

~/lab
    → menyediakan infrastructure/runtime environment

application repository
    → menyediakan application workload

Source code aplikasi tidak dimasukkan ke `~/lab`.

Perubahan infrastructure harus reproducible melalui automation.

## Memory Hook

Docker Engine
    → runtime Docker

Image
    → immutable artifact/template

Container
    → disposable instance

Dockerfile
    → recipe untuk build image

RUN
    → build time

CMD / ENTRYPOINT
    → runtime

Writable layer
    → disposable

Volume
    → persistent Docker-managed data

Bind mount
    → host filesystem ↔ container

Network
    → container-to-container communication

Service name
    → hostname dalam Compose network

-p
    → host → container port publishing

Compose
    → deklarasi + lifecycle application stack

image:
    → gunakan image

build:
    → build image

~/lab
    → infrastructure

Application repository
    → workload

Prinsip utama:

Build immutable artifact, jalankan container yang disposable, simpan data persisten di storage terpisah, dan pisahkan infrastructure dari application workload.
