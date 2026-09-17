#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 2 - PENGAYAAN GAYA DASAR MENGGUNAKAN CSS3 (SIMPUS-MINI)",
)[
  #tujuan(data: (
    "Memahami konsep dasar cascading, inheritance, dan spesifisitas pada CSS3.",
    "Menerapkan teknik pemisahan konten dan tampilan menggunakan External CSS (`<link rel=\"stylesheet\">`).",
    "Memahami model kotak (`box-sizing: border-box`) untuk tata letak elemen yang konsisten dan terprediksi.",
    "Mengimplementasikan Flexbox Layout (1 dimensi) untuk navigasi navbar responsif dengan `flex-wrap`.",
    "Mengimplementasikan CSS Grid Layout (2 dimensi) berbasis fractional unit (`fr`) pada kartu ringkasan statistik.",
    "Menerapkan pseudo-class interaktif (`:hover`) dan pseudo-class struktural (`:nth-child`, `:first-of-type`, `:last-of-type`).",
    [Menyimpan dan mengelola seluruh source code praktikum pada repositori GitHub: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Penerapan Skema Warna Global (style.css)",
      deskripsi: [
        Pada percobaan ini, skema warna tema awal (`#1d5b8a`) diubah menjadi warna oranye/kuning (`#f0ad4e`) di seluruh file `style.css`. Karena seluruh halaman terhubung menggunakan External CSS (`<link rel="stylesheet">`), perubahan ini langsung diterapkan secara otomatis dan seragam ke seluruh halaman: navbar, judul section, header tabel, dan tombol submit.

        ```css
        /* Cuplikan Perubahan Warna Tema di style.css */
        header {
            background-color: #f0ad4e;
            color: #fff;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        section h2 {
            margin-bottom: 1rem;
            color: #f0ad4e;
        }

        thead {
            background-color: #f0ad4e;
            color: #fff;
        }
        ```

        #grid(
          columns: (1fr, 1fr),
          gutter: 10pt,
          figure(
            image("../screenshots/1.1 index.html.png", width: 100%),
            caption: [1.1 Beranda (index.html)]
          ),
          figure(
            image("../screenshots/1.2 buku-list.html.png", width: 100%),
            caption: [1.2 Daftar Buku (books/list.html)]
          )
        )

        #grid(
          columns: (1fr, 1fr),
          gutter: 10pt,
          figure(
            image("../screenshots/1.3 buku-tambah.html.png", width: 100%),
            caption: [1.3 Tambah Buku (books/tambah.html)]
          ),
          figure(
            image("../screenshots/1.4 anggota-list.html.png", width: 100%),
            caption: [1.4 Daftar Anggota (members/list.html)]
          )
        )

        #align(center)[
          #figure(
            image("../screenshots/1.5 anggota-tambah.html.png", width: 55%),
            caption: [1.5 Tambah Anggota (members/tambah.html)]
          )
        ]
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 2: Penambahan Kolom Kartu Statistik (CSS Grid)",
      deskripsi: [
        Pada percobaan kedua, tata letak grid kartu ringkasan statistik pada `index.html` dikembangkan dari 3 kolom menjadi 4 kolom dengan menambahkan elemen `<article>` baru ("Buku Terlambat") dan memperbarui CSS Grid dari `repeat(3, 1fr)` menjadi `repeat(4, 1fr)`.

        ```html
        <!-- Penambahan Kartu ke-4 pada index.html -->
        <section>
            <h2>Ringkasan Statistik</h2>
            <article>
                <h3>Total Buku</h3>
                <p>12</p>
            </article>
            <article>
                <h3>Total Anggota</h3>
                <p>8</p>
            </article>
            <article>
                <h3>Peminjaman Aktif</h3>
                <p>5</p>
            </article>
            <article>
                <h3>Buku Terlambat</h3>
                <p>3</p>
            </article>
        </section>
        ```

        ```css
        /* Perubahan Aturan CSS Grid pada style.css */
        main section:nth-of-type(2) {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
        }
        ```

        #figure(
          image("../screenshots/2. index.html.png", width: 90%),
          caption: [Tampilan Grid 4 Kolom Kartu Statistik pada Beranda (index.html)]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 3: Penambahan Variasi Tombol Aksi (books/list.html)",
      deskripsi: [
        Pada percobaan ketiga, tombol ketiga ("Detail") disisipkan di antara tombol Edit dan Hapus pada tabel buku. Pada implementasi awal, CSS hanya menargetkan `:first-of-type` (Edit - oranye) dan `:last-of-type` (Hapus - merah). Penambahan tombol di tengah diisolasi menggunakan class khusus `.btn-detail` berwarna biru gelap (`#164869`) agar styling berbasis semantik tetap terjaga tanpa terpengaruh oleh urutan DOM.

        ```html
        <td>
            <button type="button">Edit</button>
            <button class="btn-detail" type="button">Detail</button>
            <button type="button">Hapus</button>
        </td>
        ```

        ```css
        .btn-detail {
            background-color: #164869;
            color: #fff;
        }
        ```

        #figure(
          image("../screenshots/3. buku-list.html.png", width: 90%),
          caption: [Tabel Buku dengan Variasi 3 Tombol Aksi (Edit, Detail, Hapus)]
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Percobaan 4: Eksperimen Responsivitas Sederhana (Navbar Flexbox)",
      deskripsi: [
        Pada percobaan keempat, lebar viewport browser diperkecil untuk menguji ketahanan properti `flex-wrap: wrap` pada header navigation bar. Ketika ruang horizontal tidak cukup untuk memuat judul `h1` dan menu tautan `nav` secara berdampingan, item navigasi secara fleksibel membungkus (_wrap_) ke baris berikutnya tanpa menyebabkan kerusakan layout atau munculnya horizontal scrollbar.

        ```css
        header {
            background-color: #f0ad4e;
            color: #fff;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap; /* Memungkinkan wrapping pada layar sempit */
        }
        ```

        #figure(
          image("../screenshots/4. index.html.png", width: 60%),
          caption: [Pengujian Responsivitas Header pada Viewport Sempit (Mobile)]
        )
      ],
      langkah: (),
      pertanyaan: (
        (
          [Bagaimana mekanisme External CSS memungkinkan pembaruan tampilan global secara efisien?],
          [External CSS memisahkan kode markup struktural HTML dari aturan presentasi visual. Melalui tag `<link rel="stylesheet" href="...">`, banyak dokumen HTML mereferensikan satu file CSS terpusat (`style.css`). Browser mengunduh dan menyimpan cache file CSS tersebut sekali. Setiap kali aturan warna tema, tipografi, atau layout diubah pada file CSS, seluruh halaman yang mengimpor file tersebut secara otomatis memperbarui tampilannya secara serentak tanpa memerlukan modifikasi pada file HTML masing-masing.]
        ),
        (
          [Mengapa selector struktural seperti :first-of-type dan :last-of-type memiliki keterbatasan dibanding class-based selector pada komponen dinamis?],
          [Selector `:first-of-type` dan `:last-of-type` bekerja murni berdasarkan *posisi/urutan indeks elemen anak* di dalam Document Object Model (DOM), bukan berdasarkan *makna/fungsi semantik* elemen tersebut. Jika struktur antarmuka bertambah atau urutan tombol berubah (misalnya menambahkan tombol aksi baru), selector posisi tersebut dapat salah sasaran atau tidak mengenai elemen baru. Menggunakan class-based selector (seperti `.btn-detail`) jauh lebih modular, eksplisit, dan tahan terhadap perubahan struktur DOM.]
        ),
      ),
    ),
  ))

  #tugas(data: (
    (
      subbab: "Tautan Repositori GitHub",
      konten: [
        Seluruh berkas kode sumber praktikum, struktur direktori aplikasi SIMPUS-Mini, serta dokumen jobsheet ini telah dikelola dan dipublikasikan melalui repositori GitHub resmi berikut:

        #v(0.5em)
        #align(center)[
          #block(
            fill: rgb("#f5f5f5"),
            stroke: 1pt + rgb("#e0e0e0"),
            radius: 4pt,
            inset: 12pt,
            width: 100%,
            [
              *URL Repositori GitHub:* \
              #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026]
            ]
          )
        ]
      ],
    ),
  ))
]
