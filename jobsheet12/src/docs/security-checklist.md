# Checklist Keamanan — Jobsheet 11

Audit kode Jobsheet 7-10 di `jobsheet11/src`, dengan bukti before/after per kerentanan.
Semua keluaran uji di bawah diambil dari `php -S 127.0.0.1:8000 -t jobsheet11/src` pada 16 November 2026.

| # | Kerentanan | Ditemukan di | Sebelum | Sesudah (perbaikan) |
|---|---|---|---|---|
| 1 | SQL Injection | Semua query di `books/`, `members/`, `auth/` | Sejak Jobsheet 8 memakai prepared statement PDO (`:parameter`) | Diaudit ulang, sudah aman: tidak ada satu pun query yang menyisipkan `$_POST`/`$_GET` langsung ke string SQL. Diuji login dengan username `' OR '1'='1` → tetap ditolak dengan pesan "Username atau password salah." |
| 2 | XSS (Cross-Site Scripting) | `books/list.php`, `books/edit.php`, `members/list.php`, `members/edit.php`, `index.php`, `includes/header.php` | Output `judul`, `pengarang`, `nama`, `alamat`, `no_hp`, `kategori`, dan nama petugas di navbar dicetak langsung tanpa escaping | Seluruh output data dibungkus `e()` (`includes/helpers.php`: `htmlspecialchars` + `ENT_QUOTES` + `UTF-8`). Diuji simpan buku berjudul `<script>alert("xss")</script>` → HTML halaman berisi `&lt;script&gt;alert(&quot;xss&quot;)&lt;/script&gt;`, tampil sebagai teks dan tidak dieksekusi. |
| 3 | CSRF (Cross-Site Request Forgery) | Form Tambah/Edit/Hapus Buku & Anggota, Login, Register | Form POST tidak memiliki token verifikasi, sehingga bisa dipicu dari situs lain selama cookie sesi korban ikut terkirim | Ditambah `includes/csrf.php` (`csrf_token()`, `csrf_field()`, `csrf_verify()`). Token per sesi disimpan di `$_SESSION['csrf_token']`, disisipkan ke semua form POST, dan diverifikasi dengan `hash_equals()` di delapan pemroses sebelum query dijalankan. Diuji POST tanpa token setelah login → HTTP 403. |
| 4 | Validasi & Sanitasi Input | `books/proses_*.php`, `members/proses_*.php` | Sudah ada validasi tipe (`is_numeric`) dan wajib-isi sejak Jobsheet 7-9 | Diaudit ulang, dipertahankan, ditambah cast eksplisit `(int)` pada `id` di hidden input form Edit agar nilai non-numerik tidak pernah ikut terkirim. |
| 5 | Session Fixation | `auth/proses_login.php` | Session ID tidak diperbarui setelah login | `session_regenerate_id(true)` dipanggil tepat setelah `password_verify()` berhasil, sebelum `$_SESSION['user']` diisi. |
| 6 | Kebocoran detail internal | `books/list.php`, `members/list.php`, seluruh `catch (PDOException)` | Pesan `PDOException::getMessage()` dicetak ke halaman, membocorkan nama tabel, kolom, dan detail koneksi | Pesan asli dikirim ke `error_log()` (stderr), sedangkan pengguna menerima pesan generik: "Data gagal dimuat. Periksa koneksi database." dan "Terjadi kesalahan pada server." |

## Catatan Implementasi

- Guard `includes/auth.php` selalu dijalankan sebelum `includes/csrf.php` di halaman proses. Pengguna yang belum login langsung di-redirect ke halaman Login dan tidak pernah mencapai `csrf_verify()`. Dibuktikan dengan POST tanpa sesi: `HTTP 302 → /auth/login.php`.
- `csrf_verify()` mengembalikan HTTP 403 dan menghentikan eksekusi dengan `die()` bila token tidak cocok atau tidak ada. Tanpa `die()`, kode `INSERT`/`UPDATE`/`DELETE` setelahnya akan tetap berjalan.
- `e()` dipakai juga untuk atribut `value="..."` di form Edit. Tanpa `ENT_QUOTES`, tanda kutip di dalam data bisa menutup atribut lebih awal dan menyisipkan atribut baru.
- Kolom `tahun` dan `stok` tetap ditampilkan tanpa `e()` karena bertipe INTEGER: PostgreSQL menolak menyimpan teks bertanda `<` ke kolom angka, sehingga nilainya tidak mungkin mengandung markup.

## Perintah verifikasi ulang

```bash
J=/tmp/jar.txt
# guard jalan lebih dulu: tanpa sesi -> 302
curl -s -o /dev/null -w "guard:%{http_code}\n" -X POST \
  http://127.0.0.1:8000/books/proses_tambah.php -d "judul=x"

# login dengan token CSRF
TOKEN=$(curl -s -c "$J" http://127.0.0.1:8000/auth/login.php \
  | grep -o 'name="csrf_token" value="[^"]*"' | cut -d'"' -f4)
curl -s -o /dev/null -w "login:%{http_code}\n" -b "$J" -c "$J" \
  -X POST http://127.0.0.1:8000/auth/proses_login.php \
  -d "username=petugas_laprak" -d "password=laprak123" -d "csrf_token=$TOKEN"

# sesi aktif tanpa token -> 403
curl -s -w "\ncsrf:%{http_code}\n" -b "$J" \
  -X POST http://127.0.0.1:8000/books/proses_tambah.php -d "judul=x"
```

Keluaran terukur: `guard:302`, `login:302`, `csrf:403` dengan badan
`Permintaan ditolak: token CSRF tidak valid atau kedaluwarsa.`
