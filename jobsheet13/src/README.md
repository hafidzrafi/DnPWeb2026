# SIMPUS-Mini

Aplikasi perpustakaan mini: data buku, data anggota, transaksi peminjaman dan pengembalian,
serta autentikasi petugas. PHP native dengan PostgreSQL melalui PDO.

## Stack

| Komponen | Keterangan |
|---|---|
| PHP | 8.2 atau lebih baru, ekstensi `pdo_pgsql` |
| Database | PostgreSQL 14 atau lebih baru |
| Frontend | HTML, CSS, JavaScript tanpa framework |

## Skema Database

```
buku                     anggota                  users                peminjaman
--------------------     ---------------------    -----------------    ------------------------
id           SERIAL PK   id           SERIAL PK   id        SERIAL PK  id             SERIAL PK
judul        VARCHAR     nama         VARCHAR     nama      VARCHAR    buku_id        FK -> buku.id
pengarang    VARCHAR     no_anggota   VARCHAR UQ  username  VARCHAR UQ anggota_id     FK -> anggota.id
tahun        INTEGER     alamat       VARCHAR     password  VARCHAR    tanggal_pinjam DATE
isbn         VARCHAR     no_hp        VARCHAR     role      VARCHAR    tanggal_kembali DATE
stok         INTEGER                                                     status         VARCHAR
kategori     VARCHAR
```

`peminjaman` merujuk `buku` dan `anggota` tanpa `ON DELETE CASCADE`: menghapus buku atau anggota
yang punya riwayat transaksi ditolak database, sehingga catatan kejadian tidak hilang diam-diam.

## Fitur per Peran

| Fitur | Tamu | Petugas |
|---|---|---|
| Beranda dan statistik | Ya | Ya |
| Daftar buku | Ya | Ya |
| Tambah, edit, hapus buku | Tidak | Ya |
| Kelola anggota | Tidak | Ya |
| Peminjaman baru | Tidak | Ya |
| Pengembalian | Tidak | Ya |
| Riwayat peminjaman | Tidak | Ya |

Tamu yang membuka halaman terkunci diarahkan ke halaman Login.

## Instalasi

Skema harus dijalankan berurutan karena `peminjaman` merujuk tabel dari dua berkas sebelumnya.

```bash
createdb simpus_mini
psql -d simpus_mini -f sql/01_buku_anggota.sql
psql -d simpus_mini -f sql/02_users.sql
psql -d simpus_mini -f sql/03_peminjaman.sql
```

Ketiga berkas memakai `CREATE TABLE IF NOT EXISTS`, jadi aman dijalankan ulang pada database yang
sudah ada.

## Konfigurasi

Kredensial database tidak ditulis di kode halaman. `includes/koneksi.php` membaca
`includes/config.php`, yang mengambil nilai dari environment variable dengan fallback ke default
lokal:

```php
return [
    'db_host' => getenv('DB_HOST') ?: 'localhost',
    'db_port' => getenv('DB_PORT') ?: '5432',
    'db_name' => getenv('DB_NAME') ?: 'simpus_mini',
    'db_user' => getenv('DB_USER') ?: 'postgres',
    'db_pass' => getenv('DB_PASS') ?: 'postgres',
];
```

| Variable | Default | Keterangan |
|---|---|---|
| `DB_HOST` | `localhost` | Host PostgreSQL |
| `DB_PORT` | `5432` | Port PostgreSQL |
| `DB_NAME` | `simpus_mini` | Nama database |
| `DB_USER` | `postgres` | User database |
| `DB_PASS` | `postgres` | Password database |
| `DB_SSLMODE` | `require` | Mode TLS; pakai `disable` untuk PostgreSQL lokal yang berjalan tanpa SSL |

`DB_SSLMODE` default `require` karena penyedia hosting umumnya mewajibkan koneksi terenkripsi.
PostgreSQL lokal dengan `ssl = off` akan menolak koneksi itu, sehingga pengembangan lokal perlu
menjalankan `DB_SSLMODE=disable`.

Jangan mengganti nilai default pada `includes/config.php` menjadi kredensial asli lalu meng-commit
berkas itu. Isi kredensial lewat environment variable di server.

## Menjalankan

Document root adalah `public/`. `includes/`, `sql/`, dan `docs/` sengaja berada di luarnya supaya
berkas skema dan konfigurasi tidak bisa diminta lewat HTTP.

Opsi 1, PHP built-in server:

```bash
DB_SSLMODE=disable php -S localhost:8000 -t public
```

Opsi 2, Laragon/Apache: arahkan document root virtual host ke `public/`, misalnya
`http://jobsheet13.test/`. Path CSS, JS, tautan, dan redirect login dihitung relatif dari
`includes/header.php` dan `includes/auth.php`, sehingga keduanya berjalan tanpa mengubah kode.

Buka `http://localhost:8000/index.php`, lalu daftarkan akun petugas pertama lewat
`auth/register.php`.

## Akun uji

| Username | Password |
|---|---|
| `petugas_j13` | `laprak123` |

## Struktur Folder

```
src/
├── public/                # Document root; hanya isi folder ini yang bisa diminta lewat HTTP
│   ├── index.php          # Beranda; statistik dihitung dari database
│   ├── auth/              # Register, login, logout
│   ├── books/             # CRUD buku
│   ├── members/           # CRUD anggota
│   ├── peminjaman/        # Peminjaman, pengembalian, riwayat
│   └── assets/
├── includes/
│   ├── config.php         # Nilai konfigurasi dari environment variable
│   ├── koneksi.php        # Koneksi PDO memakai config.php
│   ├── auth.php           # Guard login
│   ├── csrf.php           # Token CSRF
│   ├── helpers.php        # e() untuk escaping output
│   ├── header.php         # Navbar dan perhitungan path relatif
│   └── footer.php
├── sql/                   # 01-03, dijalankan berurutan
├── docs/                  # wireframe.md, security-checklist.md, manual-pengguna.md, img/
├── composer.json          # Syarat runtime: PHP 8.2+, ext-pdo, ext-pdo_pgsql
└── .gitignore
```

## Dokumen

| Berkas | Isi |
|---|---|
| `docs/wireframe.md` | Rancangan UI/UX halaman login, dashboard, dan alur peminjaman |
| `docs/security-checklist.md` | Audit keamanan dan bukti pengujiannya |
| `docs/manual-pengguna.md` | Panduan penggunaan dengan tangkapan layar |

## Catatan Pengujian

Seluruh berkas PHP lolos `php -l` tanpa kesalahan sintaks. Alur registrasi, login, tambah buku,
tambah anggota, peminjaman, pengembalian, riwayat, dan logout dijalankan pada server
`php -S` dengan PostgreSQL lokal, dan tangkapan layarnya dipakai di `docs/manual-pengguna.md`.

Override konfigurasi diuji dengan database terpisah: `DB_NAME=simpus_laprak_alt` pada port 8001
menampilkan dashboard kosong dari database baru tanpa satu baris kode pun diubah.

Setelah document root dipindah ke `public/`, permintaan `/sql/01_buku_anggota.sql` dan
`/includes/config.php` menghasilkan 404 pada server yang melayani `public/` sebagai root, sedangkan
`/assets/css/style.css` tetap 200. Alur registrasi, login, daftar buku, daftar anggota, peminjaman,
dan riwayat diuji ulang pada struktur baru.
