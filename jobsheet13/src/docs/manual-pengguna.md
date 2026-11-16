# Manual Pengguna SIMPUS-Mini

Panduan ini mengikuti tampilan aplikasi apa adanya. Setiap langkah yang membutuhkan
tangkapan layar disertai gambar dari aplikasi yang benar-benar dijalankan pada 16 November 2026.

URL contoh memakai `http://localhost:8000/...` dari PHP built-in server dengan `public/`
sebagai document root. Bila dipasang di Apache atau Nginx, ganti bagian domainnya saja; path
setelah domain tetap sama.

## 1. Registrasi dan Login Petugas

1. Buka `http://localhost:8000/auth/register.php`.
2. Isi Nama Lengkap, Username, dan Password (minimal 6 karakter), lalu klik **Daftar Sekarang**.

   ![Form registrasi](img/ss01_form_registrasi.png)

3. Setelah berhasil, aplikasi mengarahkan ke halaman Login dengan pesan "Registrasi akun
   berhasil. Silakan login." Masukkan username dan password yang baru dibuat, lalu klik **Masuk**.

   ![Form login](img/ss02_form_login.png)

4. Navbar berubah: muncul menu Peminjaman Baru, Pengembalian, dan Riwayat, nama petugas di
   kanan, serta tombol Logout. Menu itu tidak terlihat oleh tamu yang belum login.

   ![Navbar setelah login](img/ss03_navbar_setelah_login.png)

## 2. Mengelola Data Buku

1. Buka menu **Daftar Buku**, lalu klik **+ Tambah Buku**. Isi Judul, Pengarang, Tahun, ISBN,
   Stok, dan Kategori, kemudian klik **Simpan ke Database**.

   ![Form tambah buku](img/ss04_form_tambah_buku.png)

2. Buku baru langsung tampil di Daftar Buku. Kolom pencarian di kanan atas menyaring baris
   berdasarkan judul, pengarang, atau ISBN.

   ![Daftar buku](img/ss05_daftar_buku.png)

3. Tombol **Edit** pada tiap baris membuka form perubahan data. Tombol **Hapus** meminta
   konfirmasi lebih dulu; penghapusan buku yang sudah punya riwayat peminjaman akan ditolak
   database, karena tabel `peminjaman` merujuk `buku` tanpa `ON DELETE CASCADE`.

## 3. Mengelola Data Anggota

1. Buka menu **Daftar Anggota**, lalu klik **+ Tambah Anggota**. Nomor Anggota wajib diisi dan
   harus unik; Nama Lengkap wajib diisi; Nomor HP dan Alamat opsional.

   ![Form tambah anggota](img/ss06_form_tambah_anggota.png)

2. Anggota baru tampil di daftar dan langsung tersedia pada pilihan peminjaman.

   ![Daftar anggota](img/ss07_daftar_anggota.png)

## 4. Meminjamkan Buku

1. Buka menu **Peminjaman Baru**.
2. Pilih Anggota dan Buku. Dropdown buku hanya memuat judul dengan stok tersedia, dan angka
   sisa stok ditulis pada setiap pilihan. Tanggal pinjam terisi hari ini dan boleh diubah.
   Klik **Simpan Transaksi Peminjaman**.

   ![Form peminjaman](img/ss08_form_peminjaman.png)

3. Setelah tersimpan, aplikasi kembali ke daftar peminjaman aktif dengan pesan berhasil.
   Stok buku berkurang satu, dan kartu "Sedang Dipinjam" di Beranda bertambah satu.

Aturan yang berlaku saat menyimpan:

- Buku dengan stok 0 ditolak meski dipilih lewat permintaan langsung.
- Anggota yang masih menahan buku lebih dari 14 hari ditolak sampai pinjaman lamanya
  dikembalikan.

## 5. Mengembalikan Buku

1. Buka menu **Pengembalian**. Daftar hanya berisi transaksi berstatus Dipinjam.
2. Gunakan kolom pencarian untuk menyaring berdasarkan nama anggota atau judul buku, lalu klik
   **Kembalikan** pada baris yang sesuai dan setujui konfirmasi.

   ![Daftar pengembalian](img/ss09_daftar_pengembalian.png)

3. Stok buku bertambah kembali satu, transaksi hilang dari daftar aktif, dan tanggal kembali
   terisi tanggal hari ini. Menekan Kembalikan dua kali untuk transaksi yang sama ditolak.

## 6. Melihat Riwayat Peminjaman

1. Buka menu **Riwayat**.
2. Pilih nama anggota pada dropdown untuk menyaring, atau biarkan "-- Semua Anggota --" untuk
   melihat seluruh transaksi. Penyaringan berjalan saat pilihan berubah, tanpa tombol tambahan.
3. Tabel menampilkan anggota, buku, tanggal pinjam, tanggal kembali, dan status
   (Dipinjam atau Dikembalikan). Baris tanpa tanggal kembali berarti buku belum kembali.

   ![Riwayat peminjaman](img/ss10_riwayat_peminjaman.png)

## 7. Logout

Klik **Logout** di kanan atas. Sesi berakhir dan aplikasi kembali ke halaman Login. Menu yang
membutuhkan login hilang dari navbar, dan membuka halaman modul secara langsung akan
dialihkan ke halaman Login.

![Setelah logout](img/ss11_setelah_logout.png)
