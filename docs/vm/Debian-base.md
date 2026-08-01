# 🧱 Debian Base VM — Lab DevOps

## 1. Tujuan

VM ini adalah **fondasi tetap (immutable baseline)** untuk semua eksperimen:

* Docker
* Kubernetes lokal
* Ansible
* CI/CD
* simulasi server produksi

Prinsip:

> Base VM TIDAK PERNAH dioprek langsung.
> Semua eksperimen harus pakai clone atau snapshot.

---

## 2. Spesifikasi

**Hypervisor**

* KVM + libvirt (system mode)
* Storage pool: default → `/var/lib/libvirt/images`

**Resource**

* vCPU : 2
* RAM  : 2 GB
* Disk : 20 GB qcow2
* Network: default NAT

**Akses**

* User utama : `infra`
* SSH       : enabled
* sudo      : allowed

---

## 3. Cara Pembuatan (Real Command)

### 3.1 Siapkan image

```bash
cd /var/lib/libvirt/images
sudo mkdir -p base
cd base
sudo wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso
```

### 3.2 Buat VM

```bash
sudo virt-install \
  --name debian-base \
  --memory 2048 \
  --vcpus 2 \
  --disk path=/var/lib/libvirt/images/base/debian-base.qcow2,size=20 \
  --os-variant debian12 \
  --network network=default \
  --graphics none \
  --console pty,target_type=serial \
  --location /var/lib/libvirt/images/base/debian-12.5.0-amd64-netinst.iso \
  --extra-args "console=ttyS0"
```

### 3.3 Paket minimal WAJIB di dalam VM

```bash
apt update
apt install -y \
  sudo openssh-server \
  curl git htop \
  qemu-guest-agent
```

Buat user:

```bash
adduser infra
usermod -aG sudo infra
```

---

## 4. Snapshot Wajib

```bash
virsh snapshot-create-as debian-base base-clean \
  --description "Fresh debian minimal + ssh"
```

Aturan:

* ❌ Jangan kerja di base
* ✅ Selalu clone:

```bash
virt-clone \
  --original debian-base \
  --name lab-docker \
  --file /var/lib/libvirt/images/lab-docker.qcow2
```

---

## 5. Pola Kerja

### Alur Benar

1. Clone base
2. Eksperimen di hasil clone
3. Rusak? → hapus clone
4. Clone lagi dari base

### Bukan Alur Benar

* oprek debian-base langsung
* install docker di base
* jadikan base sebagai “VM kerja harian”

---

## 6. Perintah Harian

Cek VM:

```bash
virsh list --all
```

Masuk console:

```bash
virsh console debian-base
```

Revert total:

```bash
virsh snapshot-revert debian-base base-clean
```

---

## 7. Recovery Plan

Kalau rusak:

1. Hapus VM turunan
2. Revert snapshot base
3. Clone ulang

Base hanya diubah kalau:

* upgrade Debian mayor
* perubahan arsitektur lab

