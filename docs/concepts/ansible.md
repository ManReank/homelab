# Ansible

Ansible = **configuration management & automation**.

Di homelab, Ansible bekerja **setelah VM siap via cloud-init**.

```text
Golden Image
    ↓
Libvirt → VM
    ↓
Cloud-init → network, user, SSH, timezone
    ↓
Ansible → packages, Docker, services
    ↓
Configured Server
```

## Mental Model

```text
Inventory  = SIAPA yang dikelola?
Playbook   = APA yang harus dilakukan?
Task       = LANGKAH yang dilakukan?
Module     = ALAT untuk melakukan task?
Role       = Cara mengorganisasi task yang sudah kompleks/reusable
```

## Inventory

Menentukan host dan group.

```text
inventory/lab/hosts.yml
```

```text
development
└── dev-server
```

## Playbook

Workflow konfigurasi server.

```text
playbooks/bootstrap-dev-server.yml
```

Contoh:

```yaml
- name: Bootstrap development server
  hosts: development
  become: true
  tasks:
    ...
```

## Module

Module melakukan pekerjaan spesifik.

Yang sudah digunakan:

```text
apt              → package/repository
file             → file/directory
get_url          → download file
apt_repository   → repository
service          → service
user             → user/group
command          → command/inspection
```

Utamakan module daripada `shell/command` jika module yang sesuai tersedia.

## Desired State & Idempotency

Ansible mendefinisikan **kondisi akhir**, bukan sekadar command.

```yaml
state: present
```

Artinya:

> package harus ada.

Jika sudah sesuai:

```text
ok
```

Jika perlu diubah:

```text
changed
```

Karena itu playbook bisa dijalankan berulang kali tanpa terus-menerus mengubah server.

## Ad-hoc vs Playbook

```text
ansible ... -m ...
    ↓
cek / operasi cepat

ansible-playbook ...
    ↓
konfigurasi yang repeatable
```

## Become

```yaml
become: true
```

Memberikan privilege escalation untuk task yang membutuhkan root.

## Prinsip

**Server jangan diingat berdasarkan apa yang pernah kita lakukan secara manual.**

Server harus bisa direkonstruksi:

```text
VM
 ↓
Cloud-init
 ↓
SSH
 ↓
Ansible
 ↓
Ready
```

Roles belum digunakan. Jangan menambah abstraksi sebelum memang dibutuhkan.

