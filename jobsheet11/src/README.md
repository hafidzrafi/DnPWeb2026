# SIMPUS-Mini — Jobsheet 11 (Keamanan Web Dasar)

Aplikasi perpustakaan mini berbasis PHP dan PostgreSQL. Jobsheet 11 menambahkan lapisan
keamanan pada CRUD buku dan anggota: escaping output, token CSRF, regenerasi session ID,
dan penyembunyian detail error internal.

## Stack

| Komponen | Versi / keterangan |
|---|---|
| PHP | 8.3, ekstensi `pdo_pgsql` |
| Database | PostgreSQL, database `simpus_mini` |
| Frontend | HTML, CSS, JavaScript tanpa framework (`assets/`) |
| Server lokal | PHP built-in server atau Apache/Laragon |

## Struktur folder

```
src/
├── index.php              # Dashboard, diproteksi guard
├── includes/
│   ├── auth.php           # Guard login, selalu dijalankan lebih dulu
│   ├── csrf.php           # csrf_token(), csrf_field(), csrf_verify()
│   ├── helpers.php        # e() untuk escaping output
│   ├── header.php         # require helpers + csrf, navbar, flash message
│   ├── footer.php
│   └── koneksi.php        # Koneksi PDO ke PostgreSQL
├── auth/                  # login.php, register.php, proses_*.php, logout.php
├── books/                 # CRUD buku
├── members/               # CRUD anggota
├── sql/                   # Skema dan data awal
├── docs/
│   ├── wireframe.md       # Identik dengan Jobsheet 10
│   └── security-checklist.md
└── assets/                # css/style.css, js/app.js
```

## Menjalankan

### Opsi 1 — PHP built-in server

```bash
cd jobsheet11/src
php -S localhost:8000
```

Buka `http://localhost:8000/auth/login.php`.

### Opsi 2 — Laragon (Apache)

Arahkan virtual host ke folder `jobsheet11/src`, misalnya `http://jobsheet11.test/`, atau
letakkan di bawah domain proyek (`http://dp2026.test/kode-praktikum/jobsheet11/src/`).
Path CSS, JS, link, dan redirect login dihitung relatif dari `includes/header.php` dan
`includes/auth.php`, jadi keduanya berjalan tanpa perubahan.

### Database

```bash
createdb simpus_mini
psql -d simpus_mini -f sql/01_buku_anggota.sql
psql -d simpus_mini -f sql/02_users.sql
```

Kredensial koneksi ada di `includes/koneksi.php`.

## Akun uji

| Username | Password |
|---|---|
| `petugas_laprak` | `laprak123` |

Akun ini dibuat lewat halaman Register saat pengujian Jobsheet 11. Akun lain bisa
ditambahkan lewat `auth/register.php`.

## Cara menguji

Ketiga langkah di bawah ini adalah pengujian yang diminta jobsheet, dengan keluaran yang
sudah terukur.

### 1. CSRF

Login lewat browser, lalu kirim POST langsung tanpa token:

```bash
curl -X POST http://localhost:8000/books/proses_tambah.php -d "judul=x"
```

Hasil: HTTP **403** dengan badan `Permintaan ditolak: token CSRF tidak valid atau kedaluwarsa.`
Tanpa token, data tidak pernah sampai ke database.

### 2. XSS

Tambahkan buku dengan judul persis `<script>alert(1)</script>`, lalu buka Daftar Buku.

Hasil: teks tampil apa adanya sebagai `<script>alert(1)</script>` di kolom Judul, tanpa
kotak pop-up. HTML halaman berisi `&lt;script&gt;alert(&quot;1&quot;)&lt;/script&gt;`.

### 3. Urutan guard

Kirim POST ke `books/proses_tambah.php` dari sesi yang belum login sama sekali:

```bash
curl -o /dev/null -w "%{http_code}\n" -X POST \
  http://localhost:8000/books/proses_tambah.php -d "judul=x"
```

Hasil: HTTP **302** menuju `/auth/login.php`. `auth.php` berjalan lebih dulu daripada
`csrf_verify()`, jadi pengunjung tanpa sesi tidak pernah mencapai pengecekan token.

## Dokumen audit

`docs/security-checklist.md` memuat enam kerentanan dengan kondisi sebelum, perbaikan, dan
bukti pengujiannya.
