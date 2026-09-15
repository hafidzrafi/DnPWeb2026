# Jobsheet 2 (Session 02) — Dokumentasi & Jawaban: CSS3 Dasar SIMPUS-Mini
**Mata Kuliah:** Desain dan Pemrograman Web | **Kelas:** TI-2H | **Semester:** 3 (2026)

---

## Ringkasan Tugas
Berdasarkan instruksi Jobsheet 2 pada **Bab 10.4 (Ide Latihan Tambahan / Poin 1–4)**, praktikum ini menguji pemahaman implementasi CSS3 dasar pada sistem SIMPUS-Mini:
1. **Mengubah Skema Warna Global** (`#1d5b8a` diganti dengan warna tema baru, e.g. hijau tua `#1b6b45`).
2. **Menambah Kolom Kartu Statistik** (CSS Grid dari 3 kolom `repeat(3, 1fr)` menjadi 4 kolom `repeat(4, 1fr)` beserta kartu baru).
3. **Menambah Variasi Tombol Aksi** (menambahkan tombol ketiga "Detail" dengan class khusus `.btn-detail`).
4. **Uji Responsivitas Sederhana** (pengujian `flex-wrap: wrap` pada header saat lebar layar diminimalkan).

---

## 1. Mengubah Skema Warna Global (Bab 10.4 Poin 1)

### Analisis & Konsep
Pendekatan **External CSS** (`<link rel="stylesheet" href="...">`) memisahkan struktur (*presentation-independent HTML*) dari tata letak visual (*CSS*). Ketika satu kode hex warna tema diubah di file `style.css`, seluruh 5 halaman HTML (`index.html`, `buku/list.html`, `buku/tambah.html`, `anggota/list.html`, `anggota/tambah.html`) langsung merefleksikan perubahan warna secara konsisten tanpa perlu menyentuh satu pun baris kode HTML.

### Perubahan Kode CSS (`assets/css/style.css`)
Warna biru tema lama `#1d5b8a` diganti dengan warna tema baru, yaitu hijau tua (*Forest Green* `#1b6b45`):
- `a { color: #1b6b45; }` (Tautan teks)
- `header { background-color: #1b6b45; }` (Background navbar)
- `section h2 { color: #1b6b45; }` (Judul tiap kartu section)
- `main section:nth-of-type(2) article p { color: #1b6b45; }` (Angka statistik)
- `thead { background-color: #1b6b45; }` (Header tabel)
- `form button[type="submit"] { background-color: #1b6b45; }` (Tombol simpan form)
- `form button[type="submit"]:hover { background-color: #145234; }` (Hover submit disesuaikan lebih gelap)

### File Screenshot yang Dibutuhkan:
- `1.1 index.html.png`
- `1.2 buku-list.html.png`
- `1.3 buku-tambah.html.png`
- `1.4 anggota-list.html.png`
- `1.5 anggota-tambah.html.png`

---

## 2. Menambah Kolom Kartu Statistik (Bab 10.4 Poin 2)

### Analisis & Konsep
Kartu ringkasan statistik pada dashboard menggunakan **CSS Grid** (`display: grid`). Penggunaan unit fraksi (`fr` / *fractional unit*) memungkinkan pembagian ruang horizontal yang fleksibel dan proporsional.
Dengan mengganti `grid-template-columns: repeat(3, 1fr);` menjadi `repeat(4, 1fr);`, grid container secara otomatis membagi lebar menjadi 4 kolom yang sama besar tanpa memerlukan perhitungan persentase manual atau kalkulasi float/clearfix seperti pada CSS lawas.

### Perubahan Kode HTML (`index.html`)
Menambahkan elemen `<article>` keempat di dalam section ringkasan statistik:
```html
<section>
    <h2>Ringkasan Statistik</h2>
    <article>
        <h3>Total Buku</h3>
        <p>120</p>
    </article>
    <article>
        <h3>Total Anggota</h3>
        <p>45</p>
    </article>
    <article>
        <h3>Peminjaman Aktif</h3>
        <p>18</p>
    </article>
    <!-- Kartu Baru Poin 2 -->
    <article>
        <h3>Buku Terlambat</h3>
        <p>3</p>
    </article>
</section>
```

### Perubahan Kode CSS (`assets/css/style.css`)
```css
/* ===== Kartu Statistik (CSS Grid) ===== */
main section:nth-of-type(2) {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* Diubah dari repeat(3, 1fr) */
    gap: 1rem;
}
```

### File Screenshot yang Dibutuhkan:
- `2. index.html.png`

---

## 3. Menambah Variasi Tombol Aksi (Bab 10.4 Poin 3)

### Analisis & Konsep Pseudo-Class vs Class Selector
Pada kode dasar jobsheet, penataan tombol di kolom "Aksi" mengandalkan *structural pseudo-class*:
- `td button:first-of-type` mengasumsikan tombol urutan pertama adalah Edit (diberi warna oranye `#f0ad4e`).
- `td button:last-of-type` mengasumsikan tombol urutan terakhir adalah Hapus (diberi warna merah `#d9534f`).

**Masalah:** Selector `:first-of-type` dan `:last-of-type` bekerja murni berdasarkan *urutan/posisi elemen di DOM*, bukan berdasarkan *arti/semantik tombol*.
Ketika tombol ketiga ("Detail") disisipkan di antara "Edit" dan "Hapus":
- Tombol 1 ("Edit") tetap terkena `:first-of-type` (oranye).
- Tombol 3 ("Hapus") tetap terkena `:last-of-type` (merah).
- Tombol 2 ("Detail") berada di posisi tengah, sehingga tidak terkena pseudo-class apa pun. Tanpa penanganan khusus, tombol ini hanya memiliki styling dasar abu-abu bawaan browser.
- Jika tombol ditaruh di akhir atau awal, styling `:first-of-type` atau `:last-of-type` akan tertukar dan salah sasaran (misal Hapus jadi tidak merah lagi).

**Solusi Arsitektural:**
Memberikan class eksplisit seperti `.btn-detail` pada tombol detail (atau beralih ke class-based styling seperti `.btn-warning`, `.btn-info`, `.btn-danger` ala modern UI framework), lalu menetapkan warnanya secara spesifik di CSS.

### Perubahan Kode HTML (`books/list.html`)
```html
<td>
    <button type="button">Edit</button>
    <button type="button" class="btn-detail">Detail</button>
    <button type="button">Hapus</button>
</td>
```

### Perubahan Kode CSS (`assets/css/style.css`)
```css
td button.btn-detail {
    background-color: #17a2b8; /* Cyan/Info */
    color: #fff;
}

td button.btn-detail:hover {
    background-color: #138496;
}
```

### File Screenshot yang Dibutuhkan:
- `3. buku-list.html.png`

---

## 4. Eksperimen Responsivitas Sederhana (Bab 10.4 Poin 4)

### Analisis & Konsep Flexbox
Header dan navigasi dibangun menggunakan **Flexbox Layout**:
```css
header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
}
```
Ketika jendela peramban (*browser window*) diperkecil (simulasi tampilan layar ponsel / mobile viewport dengan lebar di bawah ~600px):
1. Ruang horizontal kontainer `header` tidak lagi mencukupi untuk menempatkan judul `<h1>` dan menu `<nav>` secara berdampingan dalam satu baris.
2. Karena properti `flex-wrap: wrap` aktif (bukan nilai default `nowrap`), item flex yang meluap (`nav`) secara fleksibel dan otomatis dipindahkan ke baris baru (*new flex line*) tepat di bawah `<h1>`.
3. Ini mencegah terjadinya *overflow* horizontal (potong halaman / horizontal scrollbar yang tidak diinginkan), membuktikan prinsip ketahanan layout berbasis Flexbox pada desain web adaptif sederhana.

### File Screenshot yang Dibutuhkan:
- `4. index.html.png` (diambil saat jendela browser diperkecil/resize ke ukuran HP atau lewat Device Toolbar DevTools F12).
