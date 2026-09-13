#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 1 - SISTEM PERPUSTAKAAN MINI (SIMPUS-MINI)",
)[
  #tujuan(data: (
    "Memahami struktur dasar dokumen HTML5 dengan elemen semantik (header, nav, main, section, article, footer).",
    "Menerapkan teknik navigasi relatif antar halaman menggunakan tag anchor (`<a>`) secara konsisten.",
    "Menyusun penyajian data tabular menggunakan elemen tabel HTML (`<table>`, `<thead>`, `<tbody>`, `<tr>`, `<th>`, `<td>`, `rowspan`, `colspan`).",
    "Membuat antarmuka input data formulir HTML menggunakan elemen `<form>`, `<label>`, `<input>`, `<select>`, `<option>`, dan `<button>`.",
    "Memahami mekanisme validasi input dasar bawaan HTML5 menggunakan atribut `required`, `min`, dan `max`.",
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Halaman Beranda (index.html)",
      deskripsi: [
        Halaman Beranda (`index.html`) berfungsi sebagai halaman utama aplikasi SIMPUS-Mini. Halaman ini dibangun menggunakan elemen semantik HTML5 seperti tag `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, dan `<footer>`. Halaman ini memuat menu navigasi utama serta ringkasan statistik buku dan anggota perpustakaan.

        ```html
        <header>
            <h1>SIMPUS-Mini</h1>
            <nav>
                <ul>
                    <li><a href="index.html">Beranda</a></li>
                    <li><a href="books/list.html">Daftar Buku</a></li>
                    <li><a href="books/tambah.html">Tambah Buku</a></li>
                    <li><a href="members/list.html">Daftar Anggota</a></li>
                    <li><a href="members/tambah.html">Tambah Anggota</a></li>
                </ul>
            </nav>
        </header>
        ```

        #figure(
          image("ss01_beranda.png", width: 90%),
          caption: [Tampilan Halaman Beranda (index.html) pada Browser]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 2: Tabel Daftar Buku (books/list.html)",
      deskripsi: [
        Halaman ini menampilkan koleksi data buku dalam bentuk tabel menggunakan elemen `<table>`, `<thead>`, `<tbody>`, `<tr>`, `<th>`, dan `<td>`. Pada kolom aksi, terdapat tombol Edit dan Hapus yang menggunakan `<button type="button">` agar tidak memicu pengiriman form.

        ```html
        <table border="1">
            <thead>
                <tr>
                    <th>No. Buku</th>
                    <th>Judul</th>
                    <th>Penulis</th>
                    <th>Penerbit</th>
                    <th>Jumlah Halaman</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>b001</td>
                    <td>Filosofi Teras</td>
                    <td>Henry Manampiring</td>
                    <td>Kompas</td>
                    <td>384</td>
                    <td>
                        <button type="button">Edit</button>
                        <button type="button">Hapus</button>
                    </td>
                </tr>
            </tbody>
        </table>
        ```

        #figure(
          image("ss02_daftar_buku.png", width: 90%),
          caption: [Tampilan Halaman Daftar Buku (books/list.html) pada Browser]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 3: Formulir Tambah Buku (books/tambah.html)",
      deskripsi: [
        Halaman formulir tambah buku memungkinkan pengguna memasukkan data pustaka baru. Form menggunakan pasangan `<label>` dan `<input>`, dropdown `<select>` dengan opsi `<option>`, serta pembatasan angka menggunakan atribut `min`, `max`, dan validasi wajib isi `required`.

        ```html
        <form>
            <p>
                <label for="judul">Judul</label><br>
                <input type="text" id="judul" name="judul" required>
            </p>
            <p>
                <label for="tahun">Tahun Terbit</label><br>
                <input type="number" id="tahun" name="tahun" min="1900" max="2026" required>
            </p>
            <p>
                <label for="kategori">Kategori</label><br>
                <select id="kategori" name="kategori">
                    <option value="fiksi">Fiksi</option>
                    <option value="non-fiksi">Non-Fiksi</option>
                    <option value="referensi">Referensi</option>
                </select>
            </p>
            <p><button type="submit">Simpan</button></p>
        </form>
        ```

        #figure(
          image("ss05_tambah_buku.png", width: 90%),
          caption: [Tampilan Formulir Tambah Buku (books/tambah.html) pada Browser]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 4: Tabel Daftar Anggota (members/list.html)",
      deskripsi: [
        Halaman ini merupakan tugas mandiri penerapan tabel data anggota perpustakaan. Tabel mengimplementasikan penggabungan sel baris bertingkat menggunakan atribut `rowspan="2"` pada kolom identitas serta penggabungan sel kolom menggunakan atribut `colspan="2"` pada header Jenis Kelamin (Laki-laki dan Perempuan).

        ```html
        <table border="1">
            <thead>
                <tr>
                    <th scope="col" rowspan="2">No. Anggota</th>
                    <th scope="col" rowspan="2">Nama</th>
                    <th scope="col" rowspan="2">Alamat</th>
                    <th scope="col" rowspan="2">No. HP</th>
                    <th scope="colgroup" colspan="2">Jenis Kelamin</th>
                    <th scope="col" rowspan="2">Aksi</th>
                </tr>
                <tr>
                    <th scope="col">Laki-laki</th>
                    <th scope="col">Perempuan</th>
                </tr>
            </thead>
        </table>
        ```

        #figure(
          image("ss03_daftar_anggota.png", width: 90%),
          caption: [Tampilan Halaman Daftar Anggota (members/list.html) pada Browser]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 5: Formulir Tambah Anggota (members/tambah.html)",
      deskripsi: [
        Halaman formulir tambah anggota berfungsi untuk mendaftarkan anggota baru. Formulir ini menerapkan tipe input teks untuk data identitas serta elemen pilihan radio button (`<input type="radio">`) untuk opsi jenis kelamin.

        ```html
        <form>
            <p>
                <label for="nama">Nama :</label><br>
                <input type="text" id="nama" name="nama" required>
            </p>
            <p>
                <label for="jenis-kelamin">Jenis Kelamin :</label><br>
                <input type="radio" id="laki-laki" name="jenis-kelamin" value="laki-laki">
                <label for="laki-laki">Laki-laki</label>
                <input type="radio" id="perempuan" name="jenis-kelamin" value="perempuan">
                <label for="perempuan">Perempuan</label>
            </p>
            <p><button type="submit">Simpan</button></p>
        </form>
        ```

        #figure(
          image("ss04_tambah_anggota.png", width: 90%),
          caption: [Tampilan Formulir Tambah Anggota (members/tambah.html) pada Browser]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 6: Pengujian Validasi HTML5 (Client-side Validation)",
      deskripsi: [
        Pengujian validasi dilakukan dengan langsung menekan tombol `<button type="submit">Simpan</button>` saat kolom input wajib berstatus kosong. Browser secara otomatis membatalkan pengiriman formulir dan mengarahkan fokus kursor ke input terkait disertai tooltip pesan validasi bawaan HTML5.

        #figure(
          image("ss06_validasi_form.png", width: 90%),
          caption: [Tampilan Peringatan Validasi Bawaan Browser saat Kolom Wajib Dikosongkan]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 7: Latihan Reflektif & Analisis Pemahaman",
      deskripsi: [
        Bagian ini memuat evaluasi dan pembahasan teknis dari latihan reflektif yang terdapat pada modul Jobsheet 1 SIMPUS-Mini:
      ],
      langkah: (),
      pertanyaan: (
        (
          [Kenapa field "Alamat" dan "No. HP" tidak diberi atribut `required`, sedangkan "Nama" dan "No. Anggota" diberi?],
          [Nama dan No. Anggota adalah data identitas primer yang wajib ada untuk membedakan antar peminjam di sistem perpustakaan, sehingga tidak boleh kosong saat pencatatan data. Sedangkan Alamat dan No. HP sifatnya opsional sebagai kontak pelengkap, sehingga pendaftaran awal tetap dapat diproses meskipun informasi kontak belum lengkap.]
        ),
        (
          [Apa yang akan terjadi di browser kalau kamu klik tombol "Simpan" tanpa mengisi field "Nama"?],
          [Browser akan langsung memblokir proses submit formulir dan menampilkan pop-up tooltip validasi bawaan HTML5 bertuliskan *"Please fill out this field"* pada kotak input Nama. Kursor pengguna juga secara otomatis diarahkan dan difokuskan ke field tersebut karena adanya atribut `required`.]
        ),
        (
          [Form ini juga belum punya atribut `action` pada tag `<form>`-nya — apa dampaknya saat tombol "Simpan" ditekan?],
          [Jika atribut `action` tidak ditentukan, browser secara default akan mengirimkan data formulir ke URL halaman itu sendiri (current page) dan me-refresh halaman tanpa ada pemrosesan data ke sisi server (backend maupun database).]
        ),
      ),
    ),
  ))
]
