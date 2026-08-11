# Provision Dev Server

Provisioning `dev-server` menggunakan Ansible setelah VM selesai dibuat dan diinisialisasi cloud-init.

## Flow

```text
VM
 ↓
Cloud-init
 ↓
SSH
 ↓
Ansible
 ↓
Development Environment
```

## 1. Verify Inventory

```bash
ansible-inventory --graph
ansible-inventory --list
```

Target:

```text
development
└── dev-server
```

## 2. Test Connection

```bash
ansible all -m ansible.builtin.ping
```

Expected:

```text
dev-server | SUCCESS
```

## 3. Validate Playbook

```bash
ansible-playbook playbooks/bootstrap-dev-server.yml --syntax-check
```

Optional dry-run:

```bash
ansible-playbook playbooks/bootstrap-dev-server.yml --check
```

## 4. Provision

```bash
ansible-playbook playbooks/bootstrap-dev-server.yml
```

Playbook saat ini memasang:

```text
Basic tools
    ↓
Docker repository
    ↓
Docker Engine
    ↓
Docker Compose
    ↓
Docker service
    ↓
docker group
```

## 5. Verify

```bash
ansible dev-server -m ansible.builtin.command -a "docker --version"

ansible dev-server -m ansible.builtin.command -a "docker compose version"

ansible dev-server -m ansible.builtin.command -a "docker info"

ansible dev-server -m ansible.builtin.command -a "docker run --rm hello-world"
```

## Ownership

```text
Libvirt
└── VM infrastructure

Cloud-init
└── initial OS configuration

Ansible
└── software & configuration management

Docker Compose
└── application services
```

## Rebuild Principle

Jika VM dihancurkan:

```text
Create VM
 → Cloud-init
 → SSH
 → Ansible
 → Ready
```

Target akhirnya: **tidak bergantung pada konfigurasi manual yang tidak terdokumentasi.**

