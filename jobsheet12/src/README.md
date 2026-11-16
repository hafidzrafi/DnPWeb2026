# SIMPUS-Mini — Jobsheet 12 (Integrasi Modul Peminjaman)

Aplikasi perpustakaan mini berbasis PHP dan PostgreSQL. Jobsheet 12 menambahkan modul
peminjaman yang menghubungkan tabel `buku` dan `anggota`: pencatatan peminjaman, pengembalian,
dan riwayat, dengan operasi stok di dalam database transaction.

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
├── index.php                  # Dashboard; kartu "Sedang Dipinjam" dihitung dari database
├── includes/
│   ├── auth.php               # Guard login
│   ├── csrf.php               # Token CSRF
│   ├── helpers.php            # e() untuk escaping output
│   ├── header.php             # Navbar: Buku, Anggota, Peminjaman Baru, Pengembalian, Riwayat
│   └── koneksi.php            # Koneksi PDO
├── auth/                      # Login, register, logout
├── books/                     # CRUD buku
├── members/                   # CRUD anggota
├── peminjaman/
│   ├── tambah.php             # Form peminjaman, dropdown hanya stok > 0
│   ├── proses_tambah.php      # Transaction: cek terlambat, FOR UPDATE, INSERT, UPDATE stok
│   ├── kembali.php            # Daftar transaksi aktif
│   ├── proses_kembali.php     # Transaction: FOR UPDATE, UPDATE status, UPDATE stok
│   └── riwayat.php            # Histori per anggota dengan JOIN
├── sql/                       # 01_buku_anggota.sql, 02_users.sql, 03_peminjaman.sql
├── docs/                      # wireframe.md, security-checklist.md
└── assets/
```

## Menjalankan

### Database

```bash
createdb simpus_mini
psql -d simpus_mini -f sql/01_buku_anggota.sql
psql -d simpus_mini -f sql/02_users.sql
psql -d simpus_mini -f sql/03_peminjaman.sql
```

`03_peminjaman.sql` memakai `CREATE TABLE IF NOT EXISTS`, jadi aman dijalankan ulang tanpa
mengganggu tabel yang sudah ada. Foreign key ditulis tanpa `ON DELETE CASCADE`: menghapus
buku yang punya riwayat peminjaman akan ditolak database, bukan menghapus riwayatnya diam-diam.

### Aplikasi

Opsi 1, PHP built-in server:

```bash
cd jobsheet12/src
php -S localhost:8000
```

Opsi 2, Laragon/Apache: arahkan virtual host ke `jobsheet12/src`, misalnya
`http://jobsheet12.test/`. Path CSS, JS, link, dan redirect login dihitung relatif dari
`includes/header.php` dan `includes/auth.php`, jadi keduanya berjalan.

## Akun uji

| Username | Password |
|---|---|
| `petugas_laprak` | `laprak123` |

## Aturan bisnis yang diterapkan

| Aturan | Letak |
|---|---|
| Buku dengan stok 0 tidak muncul di dropdown peminjaman | `peminjaman/tambah.php`: `WHERE stok > 0` |
| Stok tidak boleh negatif meski dua peminjaman berjalan bersamaan | `peminjaman/proses_tambah.php`: `SELECT ... FOR UPDATE` di dalam transaction |
| Anggota dengan pinjaman aktif lebih dari 14 hari tidak boleh meminjam lagi | `peminjaman/proses_tambah.php`: hitung `tanggal_pinjam < CURRENT_DATE - INTERVAL '14 days'` |
| Transaksi yang sudah dikembalikan tidak bisa dikembalikan dua kali | `peminjaman/proses_kembali.php`: cek `status = 'dipinjam'` di dalam transaction |
| Peminjaman dan pengurangan stok berhasil atau gagal bersama | `beginTransaction()` / `commit()` / `rollBack()` pada kedua pemroses |

## Pengujian end-to-end

Urutan yang dijalankan pada 16 November 2026, dengan hasil terukur:

| Langkah | Hasil |
|---|---|
| Login `petugas_laprak` | HTTP 302 → `/index.php` |
| Dashboard sebelum transaksi | Sedang Dipinjam **3**, stok Clean Code **6** |
| Peminjaman Baru: Siti Aminah meminjam Clean Code | HTTP 302 → `kembali.php` |
| Stok Clean Code setelah peminjaman | **5** |
| Kartu Sedang Dipinjam | **4** |
| Pengembalian transaksi tersebut | HTTP 302, stok kembali **6**, kartu kembali **3** |
| Pengembalian transaksi yang sama untuk kedua kali | Ditolak: "Transaksi tidak ditemukan atau buku sudah dikembalikan sebelumnya." |
| POST ke `proses_kembali.php` tanpa token CSRF | HTTP 403 |
| Anggota dengan pinjaman aktif sejak 12 Oktober (35 hari) mencoba meminjam | Ditolak: "Anggota masih memiliki pinjaman aktif lebih dari 14 hari." |
| Dua peminjaman bersamaan untuk buku stok 1 | Hanya satu baris `peminjaman` terbentuk, stok menjadi **0**, tidak pernah negatif |
| Buku stok 0 pada dropdown peminjaman | Tidak muncul |
| POST dengan `buku_id` buku stok 0 | Ditolak: "Stok buku tidak tersedia." |

## Cara menguji sendiri

```bash
J=/tmp/jar.txt
TOKEN=$(curl -s -c "$J" http://localhost:8000/auth/login.php \
  | grep -o 'name="csrf_token" value="[^"]*"' | cut -d'"' -f4)
curl -s -o /dev/null -b "$J" -c "$J" -X POST http://localhost:8000/auth/proses_login.php \
  -d "username=petugas_laprak" -d "password=laprak123" -d "csrf_token=$TOKEN"

# tanpa token -> 403
curl -s -w "\n%{http_code}\n" -b "$J" -X POST \
  http://localhost:8000/peminjaman/proses_kembali.php -d "id=1"
```

Untuk menguji race condition, jalankan dua POST peminjaman untuk `buku_id` yang sama secara
bersamaan (`&` pada shell) dan periksa `SELECT stok FROM buku WHERE id = <id>`: nilainya tidak
pernah negatif, dan hanya satu baris `peminjaman` yang terbentuk.

## Dokumen

`docs/wireframe.md` dan `docs/security-checklist.md` identik dengan versi Jobsheet 11.
Jobsheet 12 tidak menambah rancangan UI maupun audit keamanan baru; ia mengimplementasikan
apa yang sudah dirancang dan diamankan sebelumnya.
