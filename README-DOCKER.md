# Universal Web Development Docker Stack (PHP 8.3, PostgreSQL 17, NGINX 1.26, Adminer)

Lingkungan Docker serbaguna dan berstandar industri untuk menggantikan peran Laragon di macOS/Linux/Windows. Kompatibel untuk berbagai kebutuhan: project PHP Native, framework modern (Laravel, Symfony), maupun praktikum perkuliahan.

---

## 📌 Spesifikasi Versi Resmi (Hardcoded LTS / Stable)

| Layanan | Image Tag | Basis Rilis Resmi | Keterangan & Fitur Utama |
|---|---|---|---|
| **PHP** | `php:8.3-fpm-alpine` | PHP 8.3 FPM Alpine | Composer 2, PostgreSQL (`pdo_pgsql`), MySQL (`pdo_mysql`), GD, Intl, Zip, BCMath, OPcache, Permission non-root (`www-data`) |
| **Nginx** | `nginx:1.26-alpine` | NGINX 1.26 Stable | FastCGI buffer tuning (128k/256k), Gzip, Security Headers, Universal URL router, Autoindex |
| **PostgreSQL** | `postgres:17-alpine` | PostgreSQL 17 Alpine | Dukungan 5 tahun (hingga Nov 2029), Native Healthcheck (`pg_isready`), Persistent Volume |
| **Adminer** | `adminer:4.8.1` | Adminer 4.8.1 | Web Database GUI ringan multi-database (port 8080) |

---

## 🚀 Perintah Dasar

### 1. Membangun dan Menjalankan Container
```bash
docker compose up -d --build
```

### 2. Melihat Status & Healthcheck Container
```bash
docker compose ps
```

### 3. Menghentikan Container
```bash
docker compose down
```

---

## 🌐 Endpoint Akses Browser

* **Web Root**: `http://localhost/` (atau `http://web-nginx.orb.local/` via OrbStack)
  * *Contoh akses folder*: `http://localhost/PemogramanWeb2026/kode-praktikum/jobsheet-08/`
* **Adminer (Database Manager)**: `http://localhost:8080/`
  * **System**: `PostgreSQL`
  * **Server**: `postgres` *(nama service container)*
  * **Username**: Nilai `DB_USERNAME` di `.env` (default: `postgres`)
  * **Password**: Nilai `DB_PASSWORD` di `.env` (default: `postgres`)
  * **Database**: Nilai `DB_DATABASE` di `.env` (default: `app_db`)

---

## 💻 Menjalankan Composer & PHP CLI di Container

Anda tidak perlu menginstal PHP atau Composer di host macOS:
```bash
# Menjalankan Composer
docker compose exec php composer -V
docker compose exec php composer install

# Menjalankan PHP CLI
docker compose exec php php -v
docker compose exec php php -m
```

---

## 🛠️ CLI PostgreSQL & Import Database

### 1. Masuk ke interactive psql:
```bash
docker compose exec postgres psql -U postgres -d app_db
```

### 2. Import SQL Skema Praktikum (Contoh jobsheet `simpus_mini`):
Jika ingin membuat database baru bernama `simpus_mini` untuk praktikum:
```bash
# Buat database simpus_mini
docker compose exec postgres psql -U postgres -c "CREATE DATABASE simpus_mini;"

# Import file SQL
docker compose exec -T postgres psql -U postgres -d simpus_mini < PemogramanWeb2026/kode-praktikum/jobsheet-13/sql/01_buku_anggota.sql
docker compose exec -T postgres psql -U postgres -d simpus_mini < PemogramanWeb2026/kode-praktikum/jobsheet-13/sql/02_users.sql
docker compose exec -T postgres psql -U postgres -d simpus_mini < PemogramanWeb2026/kode-praktikum/jobsheet-13/sql/03_peminjaman.sql
```

---

## ⚙️ Kustomisasi Konfigurasi

* **Variabel Lingkungan**: Sesuaikan di berkas [.env](file:///Users/rafi/Projects/05_Academic/sem-3/web/.env).
* **Konfigurasi PHP (`php.ini`)**: Edit [docker/php/conf.d/custom.ini](file:///Users/rafi/Projects/05_Academic/sem-3/web/docker/php/conf.d/custom.ini).
* **Konfigurasi NGINX**: Edit [docker/nginx/default.conf](file:///Users/rafi/Projects/05_Academic/sem-3/web/docker/nginx/default.conf).
