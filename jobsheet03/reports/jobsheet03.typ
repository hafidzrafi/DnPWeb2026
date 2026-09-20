#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 3 - DESAIN WEB RESPONSIF (CSS MURNI & BOOTSTRAP 5)",
  repository: "https://github.com/hafidzrafi/DnPWeb2026",
  footer_text: "Desain dan Pemrograman Web -- Jobsheet 3",
)[
  #tujuan(data: (
    "Memahami konsep dasar Responsive Web Design (RWD) dan peran fundamental tag `<meta name=\"viewport\">` pada peramban mobile.",
    "Menguasai teknik Media Queries (`@media`) serta strategi penentuan breakpoint dengan pendekatan Desktop-First (`max-width`).",
    "Mengimplementasikan interaktivitas murni CSS tanpa JavaScript menggunakan teknik Checkbox Hack (`:checked` dan sibling combinator `~`) untuk menu hamburger navigasi mobile.",
    "Menerapkan pola kontainer tabel responsif berbasis pembungkus `overflow-x: auto` (`.table-responsive`) untuk mencegah layout overflow pada layar sempit.",
    "Menerapkan CSS Grid adaptif yang merespons perubahan resolusi layar secara dinamis (4 kolom desktop, 2 kolom tablet, hingga 1 kolom mobile).",
    "Membandingkan karakteristik implementasi CSS murni (handwritten CSS) dengan framework modern (Bootstrap 5) dari segi kontrol, arsitektur, dan beban dependensi.",
    [Menyimpan dan mengelola seluruh source code praktikum pada repositori GitHub: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Bagian 1: Desain Web Responsif Menggunakan CSS Murni (Jobsheet 3.2)",
      deskripsi: [
        Pada bagian pertama ini, seluruh arsitektur responsif aplikasi SIMPUS-Mini dibangun menggunakan CSS murni (*hand-written CSS*) tanpa pustaka maupun skrip eksternal. Pendekatan yang digunakan adalah *Desktop-First*, di mana gaya dasar ditulis untuk resolusi layar lebar (> 768px), lalu ditimpa secara bertahap menggunakan `@media (max-width: ...)` untuk layar tablet dan mobile.

        === 1.1 Konfigurasi Viewport Meta Tag
        Langkah pertama yang krusial adalah menambahkan tag `<meta name="viewport">` pada seluruh dokumen HTML (`index.html`, `books/*.html`, dan `members/*.html`). Tanpa tag ini, peramban perangkat seluler secara default akan merender halaman pada resolusi virtual sebesar 980px dan memperkecilnya (*zoom out*), sehingga media query CSS tidak akan terpicu secara akurat sesuai ukuran fisik layar perangkat.

        ```html
        <!-- Deklarasi Wajib di dalam tag <head> pada seluruh berkas HTML -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        ```

        === 1.2 Navigasi Mobile dengan Checkbox Hack (Tanpa JavaScript)
        Alih-alih memakai JavaScript untuk menangani interaksi buka-tutup menu navigasi pada layar kecil, praktikum ini menerapkan teknik *Checkbox Hack*. Komponen terdiri dari elemen `<input type="checkbox">` yang disembunyikan dan sebuah `<label>` berlambang ikon hamburger (`☰`).

        ```html
        <!-- Struktur Header & Navigasi di HTML -->
        <header>
            <h1>SIMPUS-Mini</h1>
            <input type="checkbox" id="nav-toggle" class="nav-toggle">
            <label for="nav-toggle" class="nav-toggle-label">&#9776;</label>
            <nav>
                <ul>
                    <li><a href="index.html">Beranda</a></li>
                    <li><a href="books/list.html">Daftar Buku</a></li>
                    ...
                </ul>
            </nav>
        </header>
        ```

        Ketika pengguna mengetuk elemen `<label>`, peramban secara otomatis mencentang elemen `<input type="checkbox">` yang berpasangan dengannya melalui atribut `for="nav-toggle"`. Sibling combinator (`~`) pada CSS mendeteksi state `:checked` tersebut untuk mengubah properti tampilan menu `<nav>`:

        ```css
        /* Kontrol Tampilan Menu via Sibling Combinator */
        .nav-toggle {
            display: none;
        }

        .nav-toggle-label {
            display: none;
            cursor: pointer;
            font-size: 1.5rem;
            line-height: 1;
        }

        @media (max-width: 480px) {
            .nav-toggle-label {
                display: block;
            }

            header nav {
                display: none;
                width: 100%;
                order: 3;
                margin-top: 1rem;
            }

            .nav-toggle:checked ~ nav {
                display: block;
            }

            header nav ul {
                flex-direction: column;
                gap: 0.75rem;
            }
        }
        ```

        === 1.3 Pola Kontainer Tabel Responsif
        Tabel data (`<table>`) memiliki sifat intrinsik tidak mudah mengecil ketika data kolom di dalamnya lebar. Untuk menghindari kerusakan tata letak halaman akibat *horizontal overflow*, tabel dibungkus di dalam elemen kontainer `<div class="table-responsive">`.

        ```css
        /* Pola Kontainer Tabel Responsif di style.css */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .table-responsive table {
            min-width: 500px;
        }
        ```
        Dengan aturan ini, ketika lebar layar kurang dari lebar minimum tabel, bilah gulir (*scroll bar*) horizontal hanya akan muncul secara lokal di dalam batas kontainer tabel, sementara elemen header, navigasi, dan footer tetap statis dan rapi.

        === 1.4 Penerapan Breakpoint Media Query (Desktop-First)
        Aturan CSS responsif ditempatkan di bagian paling bawah berkas `style.css` agar aturan *cascading* menimpa (*override*) deklarasi gaya dasar di atasnya:

        ```css
        /* Breakpoint Tablet (768px ke bawah) */
        @media (max-width: 768px) {
            main section:nth-of-type(2) {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Breakpoint Mobile (480px ke bawah) */
        @media (max-width: 480px) {
            header {
                position: relative;
            }

            main section:nth-of-type(2) {
                grid-template-columns: repeat(1, 1fr);
            }

            form input, form select {
                max-width: 100%;
            }
        }
        ```
      ],
      langkah: (
        "Menambahkan tag `<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">` pada seluruh berkas HTML dalam folder `jobsheet03/src/`.",
        "Menyisipkan elemen `<input type=\"checkbox\" id=\"nav-toggle\" class=\"nav-toggle\">` dan `<label for=\"nav-toggle\" class=\"nav-toggle-label\">&#9776;</label>` tepat sebelum elemen `<nav>` pada seluruh berkas HTML.",
        "Membungkus seluruh elemen `<table>` pada `books/list.html` dan `members/list.html` menggunakan pembungkus `<div class=\"table-responsive\">`.",
        "Menambahkan aturan styling responsif di bagian bawah `style.css`, mencakup `.nav-toggle`, `.nav-toggle-label`, `.table-responsive`, serta blok media queries `@media (max-width: 768px)` dan `@media (max-width: 480px)`.",
        "Melakukan verifikasi responsivitas halaman di Google Chrome DevTools pada viewport Desktop (1024px), Tablet (768px), dan Mobile (375px).",
      ),
      pertanyaan: (
        (
          "Apa fungsi dari tag `<meta name=\"viewport\">` dan apa dampaknya jika dihilangkan?",
          "Tag `<meta name=\"viewport\">` menginstruksikan peramban seluler untuk menyamakan lebar area pandang (*viewport*) virtual dengan lebar fisik perangkat (`width=device-width`) dan menyetel tingkat perbesaran awal ke skala 1:1 (`initial-scale=1.0`). Jika dihilangkan, peramban mobile akan mengasumsikan viewport default sebesar 980px, merender halaman seolah-olah di layar desktop lalu mengecilkannya secara paksa (*zoom out*), sehingga breakpoint media query tidak akan bekerja secara optimal.",
        ),
        (
          "Bagaimana mekanisme Checkbox Hack dapat menggantikan JavaScript untuk menu interaktif?",
          "Checkbox hack memanfaatkan fungsionalitas native form HTML di mana mengklik `<label>` akan memicu perubahan atribut checked pada `<input type=\"checkbox\">` yang terhubung via atribut `for` dan `id`. Di sisi CSS, status ini ditangkap oleh pseudo-class `:checked` dan dikombinasikan dengan general sibling combinator (`~`). Selektor `.nav-toggle:checked ~ nav` secara reaktif mengubah properti display dari `none` menjadi `block`, menciptakan interaksi buka-tutup menu secara murni melalui engine CSS browser tanpa beban skrip JS eksternal.",
        ),
        (
          "Mengapa teknik scroll horizontal lebih diutamakan untuk tabel data dibandingkan pemampatan kolom?",
          "Memampatkan banyak kolom data pada layar smartphone yang sempit akan memotong teks atau memaksa pembungkusan kata (*word-wrapping*) yang ekstrem, sehingga data angka dan teks menjadi sulit dibaca serta merusak perbandingan visual antar baris. Dengan teknik scroll horizontal berbatas kontainer (`overflow-x: auto`), integritas struktur tabel, padding sel, dan keterbacaan data tetap terjaga 100% sementara pengguna cukup menggeser tabel secara alami dengan sentuhan jari.",
        ),
        (
          "Mengapa blok media query Desktop-First wajib diletakkan di bagian paling bawah berkas CSS?",
          "Karena prinsip cascading CSS mengeksekusi aturan dari atas ke bawah. Ketika selektor memiliki nilai spesifisitas yang sama, aturan yang dideklarasikan paling akhir akan memenangkan prioritas (*override*). Jika blok `@media (max-width: 768px)` diletakkan sebelum deklarasi dasar `main section:nth-of-type(2) { grid-template-columns: repeat(4, 1fr); }`, maka deklarasi dasar di bawahnya akan menimpa kembali aturan media query tersebut sehingga tampilan tidak akan berubah.",
        ),
      ),
    ),
    (
      subbab: "Hasil Pengujian Tampilan Responsif (CSS Murni)",
      deskripsi: [
        Pengujian visual dilakukan secara langsung melalui *Responsive Design Mode* pada peramban web untuk membuktikan kebenaran implementasi tata letak di berbagai resolusi layar.

        #v(1em)
        *1. Tampilan Desktop (Resolusi 1024px)* \
        Pada tampilan desktop, navbar berada dalam posisi horizontal penuh tanpa ikon hamburger, dan kartu ringkasan statistik berjejer rapi dalam 4 kolom horizontal (`repeat(4, 1fr)`).

        #align(center)[
          #figure(
            image("../screenshots/ss01_desktop_1024px.png", width: 90%),
            caption: [Tampilan Beranda pada Resolusi Desktop 1024px (4 Kolom Kartu)]
          )
        ]

        #v(1em)
        *2. Tampilan Tablet (Resolusi 768px)* \
        Ketika resolusi diperkecil ke 768px, breakpoint `@media (max-width: 768px)` terpicu. Susunan kartu ringkasan secara otomatis beradaptasi menjadi 2 kolom dan 2 baris (`repeat(2, 1fr)`) secara proporsional.

        #align(center)[
          #figure(
            image("../screenshots/ss02_tablet_768px.png", width: 90%),
            caption: [Tampilan Beranda pada Resolusi Tablet 768px (Adaptasi Grid 2 Kolom)]
          )
        ]

        #v(1em)
        *3. Tampilan Mobile (Resolusi 375px - Menu Tertutup & Terbuka)* \
        Pada layar ponsel cerdas (375px), breakpoint `@media (max-width: 480px)` aktif. Link menu navigasi disembunyikan dan digantikan oleh ikon hamburger `☰`. Kartu ringkasan tertata vertikal 1 kolom penuh. Ketika ikon hamburger ditekan, menu navigasi turun ke bawah secara vertikal tanpa reload halaman.

        #grid(
          columns: (1fr, 1fr),
          gutter: 10pt,
          figure(
            image("../screenshots/ss03_mobile_375px_menu_closed.png", width: 100%),
            caption: [Mobile (375px): Menu Tertutup]
          ),
          figure(
            image("../screenshots/ss04_mobile_375px_menu_opened.png", width: 100%),
            caption: [Mobile (375px): Menu Terbuka]
          )
        )

        #v(1em)
        *4. Tampilan Tabel Responsif pada Mobile (Resolusi 375px)* \
        Pada halaman daftar buku (`books/list.html`), tabel data tetap mempertahankan lebar minimumnya. Kontainer `.table-responsive` mengisolasi overflow sehingga pengguna dapat menggeser tabel ke kanan untuk melihat informasi penerbit, jumlah halaman, dan tombol aksi tanpa merusak layout utama.

        #grid(
          columns: (1fr, 1fr),
          gutter: 10pt,
          figure(
            image("../screenshots/ss05_table_responsive_left.png", width: 100%),
            caption: [Tabel Mobile: Posisi Awal (Kiri)]
          ),
          figure(
            image("../screenshots/ss06_table_responsive_scrolled.png", width: 100%),
            caption: [Tabel Mobile: Di-scroll (Kanan)]
          )
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
    (
      subbab: "Bagian 2: Desain Web Responsif Menggunakan Framework Bootstrap 5 (Jobsheet 3.1)",
      deskripsi: [
        Pada bagian kedua ini, arsitektur responsif aplikasi SIMPUS-Mini direfaktor menggunakan framework CSS modern yaitu *Bootstrap 5.3*. Berbeda dengan pendekatan CSS murni yang mengandalkan penulisan kode manual beratus-ratus baris, Bootstrap menerapkan filosofi *utility-first* dan komponen siap pakai (*pre-built components*) berbasis sistem grid 12 kolom dan modul JavaScript interaktif.

        === 2.1 Integrasi Bootstrap 5 via CDN & Filosofi Mobile-First
        Integrasi dilakukan dengan menghubungkan *Content Delivery Network* (CDN) resmi Bootstrap pada seluruh dokumen HTML. Berkas pustaka CSS disisipkan di dalam tag `<head>`, sedangkan pustaka JavaScript *bundle* (yang menyertakan Popper.js) ditempatkan tepat sebelum penutup tag `</body>`.

        ```html
        <!-- CSS Bootstrap 5.3.3 di dalam tag <head> -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- JS Bundle Bootstrap 5.3.3 tepat sebelum </body> -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        ```

        Bootstrap dibangun dengan filosofi *Mobile-First*, di mana gaya dasar ditargetkan untuk layar terkecil terlebih dahulu tanpa media query, lalu secara bertahap ditingkatkan (*progressive enhancement*) untuk layar yang lebih lebar menggunakan `@media (min-width: ...)` dengan *infix breakpoint* standar:
        - `sm` ($>= 576$ px): Ponsel horizontal (*landscape*).
        - `md` ($>= 768$ px): Tablet.
        - `lg` ($>= 992$ px): Layar laptop/desktop standar.
        - `xl` ($>= 1200$ px) & `xxl` ($>= 1400$ px): Monitor lebar.

        === 2.2 Komponen Navbar Responsif & JavaScript Collapse
        Jika pada CSS murni interaksi menu navigasi mobile memerlukan trik *Checkbox Hack*, Bootstrap 5 menyediakan komponen navbar bawaan dengan perilaku responsif otomatis melalui kelas `.navbar`, `.navbar-expand-md`, dan tombol `.navbar-toggler`.

        ```html
        <nav class="navbar navbar-expand-md navbar-dark" style="background-color: #1d5b8a;">
            <div class="container">
                <a class="navbar-brand fw-bold" href="index.html">SIMPUS-Mini</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                        data-bs-target="#navbarNav" aria-controls="navbarNav" 
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link active" href="index.html">Beranda</a></li>
                        <li class="nav-item"><a class="nav-link" href="books/list.html">Daftar Buku</a></li>
                        <li class="nav-item"><a class="nav-link" href="books/tambah.html">Tambah Buku</a></li>
                        <li class="nav-item"><a class="nav-link" href="members/list.html">Daftar Anggota</a></li>
                        <li class="nav-item"><a class="nav-link" href="members/tambah.html">Tambah Anggota</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        ```

        Mekanisme buka-tutup menu dikendalikan oleh Data Attributes API:
        - `data-bs-toggle="collapse"`: Menginstruksikan JavaScript Bootstrap untuk mengaktifkan perilaku kolaps.
        - `data-bs-target="#navbarNav"`: Menunjuk elemen kontainer menu yang akan dianimasikan tinggi (*height transition*) dan status keterlihatannya (`.collapse.show`).
        - `aria-expanded` & `aria-label`: Menjaga aksesibilitas (*web accessibility*) bagi pengguna pembaca layar (*screen reader*).

        === 2.3 Sistem Grid 12 Kolom & Komponen Card
        Sistem grid Bootstrap membagi lebar satu baris (`.row`) menjadi 12 kolom virtual. Kartu statistik pada beranda dibungkus di dalam kelas `.container` dan menggunakan kombinasi kelas responsif `.col-12.col-md-4`:

        ```html
        <div class="row g-4">
            <div class="col-12 col-md-4">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-body text-center p-4">
                        <h6 class="text-secondary mb-3">Total Buku</h6>
                        <div class="display-6 fw-bold" style="color: #1d5b8a;">12</div>
                    </div>
                </div>
            </div>
            <!-- Kartu 2 dan Kartu 3 dengan struktur serupa -->
        </div>
        ```

        Logika proporsional 12 kolom bekerja sebagai berikut:
        1. *Mobile Viewport* (`col-12`): Setiap kartu memakan 12 unit grid penuh ($12 / 12 = 1$ kartu per baris), sehingga ketiga kartu tersusun bertumpuk vertikal.
        2. *Desktop/Tablet Viewport* (`col-md-4`): Pada resolusi $>= 768$ px, setiap kartu hanya memakan 4 unit grid ($12 / 4 = 3$ kartu per baris), sehingga ketiga kartu tertata rapi berdampingan secara horizontal dalam satu baris. Kelas pendukung seperti `.shadow-sm`, `.border-0`, dan `h-100` memberikan efek elevasi bayangan modern tanpa perlu menulis deklarasi `box-shadow` manual.

        === 2.4 Komponen Tabel & Formulir Bootstrap
        Penyajian data tabel dan formulir disederhanakan menggunakan kelas utilitas semantik:
        - *Tabel Responsif*: Dibungkus dalam `<div class="table-responsive">` bawaan Bootstrap yang otomatis mengaktifkan *horizontal scrolling* saat lebar tabel melebihi kontainer. Tabel diberi kelas `.table.table-striped.table-hover` untuk efek baris belang dan interaksi kursor.
        - *Tombol Aksi Semantik*: Tombol "Edit" menggunakan `.btn.btn-warning.btn-sm` dan tombol "Hapus" menggunakan `.btn.btn-danger.btn-sm` yang secara visual langsung menyampaikan makna aksi melalui warna fungsional standar.
        - *Formulir Modern*: Pembungkus `.mb-3` mengatur margin bawah konsisten antar input, dipadukan dengan `.form-control` untuk bidang teks/angka dan `.form-select` untuk dropdown, menghasilkan tampilan form berstandar industri dengan transisi fokus (*focus glow*) otomatis.

        === 2.5 Analisis Komparasi Arsitektur: CSS Murni vs Bootstrap 5
        Berdasarkan implementasi kedua jobsheet, berikut adalah perbandingan komprehensif antara penulisan CSS Murni (Jobsheet 3.2) dan Framework Bootstrap 5 (Jobsheet 3.1):

        #table(
          columns: (1.5fr, 2.2fr, 2.3fr),
          stroke: 0.5pt + rgb("#cbd5e1"),
          inset: 7pt,
          fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else { none },
          align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
          table.header(
            [*Aspek Arsitektur*], [*CSS Murni (Jobsheet 3.2)*], [*Bootstrap 5 (Jobsheet 3.1)*]
          ),
          [Kontainer Konten], [`max-width: 1000px; margin: 0 auto;`], [Kelas utilitas `.container`],
          [Sistem Tata Letak], [CSS Grid manual `repeat(4, 1fr)`], [Grid 12 kolom (`.row` + `.col-md-4`)],
          [Navigasi Mobile], [Checkbox Hack (`:checked ~ nav`)], [JavaScript Collapse (`data-bs-*`)],
          [Tabel Belang & Hover], [Selektor `:nth-child(even)` & `:hover`], [Kelas `.table-striped` & `.table-hover`],
          [Tabel Responsif], [Deklarasi custom `.table-responsive`], [Kelas bawaan `.table-responsive`],
          [Tombol Aksi], [Gaya tombol manual pada tag `button`], [Kelas semantik `.btn-warning`, `.btn-danger`],
          [Komponen Formulir], [Styling manual `input`, `select`], [Kelas `.form-control` & `.form-select`],
          [Filosofi Breakpoint], [Desktop-First (`max-width: 768px/480px`)], [Mobile-First (`min-width` + infix `sm/md/lg`)],
          [Beban CSS Custom], [~245 baris kode pada `style.css`], [Hanya ~16 baris penimpaan warna brand],
        )

        *Kebutuhan CSS Custom dan Penggunaan `!important`:* \
        Meskipun Bootstrap menyediakan ratusan kelas siap pakai, berkas `assets/css/style.css` pada praktikum ini tetap mempertahankan 16 baris kode dengan anotasi `!important`:
        ```css
        .navbar-brand, .nav-link { color: #fff !important; }
        .nav-link:hover, .nav-link.active { color: #d9e8f5 !important; }
        form button[type="submit"]:hover,
        button[type="submit"]:hover { background-color: #164869 !important; }
        ```
        Hal ini diperlukan karena palet tema bawaan Bootstrap (`primary` = `#0d6efd`) berbeda dengan warna identitas SIMPUS-Mini (`#1d5b8a`). Karena selektor internal Bootstrap memiliki tingkat spesifisitas tinggi, deklarasi `!important` digunakan untuk memastikan warna brand kustom berhasil menimpa (*override*) aturan bawaan tanpa harus memperpanjang rantai selektor CSS secara berlebihan.
      ],
      langkah: (
        "Menyiapkan struktur direktori berkas `jobsheet03-bootstrap/src/` yang mencakup `index.html`, `books/list.html`, `books/tambah.html`, `members/list.html`, `members/tambah.html`, serta `assets/css/style.css`.",
        "Mengintegrasikan CDN Bootstrap 5.3.3 (`bootstrap.min.css` pada tag `<head>` dan `bootstrap.bundle.min.js` sebelum penutup tag `</body>`) pada seluruh berkas HTML.",
        "Mengimplementasikan komponen `.navbar` responsif lengkap dengan `.navbar-brand`, tombol hamburger `.navbar-toggler`, serta menu navigasi collapsible berbasis Data Attributes API (`data-bs-toggle=\"collapse\"` dan `data-bs-target=\"#navbarNav\"`).",
        "Menyusun tata letak beranda menggunakan sistem grid 12 kolom Bootstrap (`.container`, `.row`, dan `.col-12.col-md-4`) untuk merender 3 kartu ringkasan statistik (`.card.shadow-sm`).",
        "Menerapkan utility class Bootstrap pada antarmuka tabel data menggunakan `.table.table-striped.table-hover` di dalam pembungkus `.table-responsive`, serta tombol aksi semantik `.btn-warning` dan `.btn-danger`.",
        "Memperbarui formulir input buku dan anggota menggunakan pembungkus `.mb-3`, `.form-label`, `.form-control`, serta `.form-select`.",
        "Menambahkan aturan penimpaan (*style override*) pada `assets/css/style.css` untuk menyesuaikan warna brand SIMPUS-Mini (`#1d5b8a` dan `#164869`).",
        "Menjalankan server PHP lokal pada porta 8000 dan menguji responsivitas antarmuka di Chrome DevTools pada resolusi 1024px, 768px, dan 375px.",
      ),
      pertanyaan: (
        (
          "Apa perbedaan mendasar antara pendekatan Desktop-First pada CSS Murni dengan Mobile-First pada Bootstrap 5?",
          "Pendekatan Desktop-First (Jobsheet 3.2) merancang antarmuka untuk resolusi desktop terlebih dahulu, kemudian menggunakan media query `max-width` untuk memodifikasi atau menyederhanakan tata letak saat layar mengecil. Sebaliknya, pendekatan Mobile-First (Bootstrap 5) merancang tata letak dasar untuk perangkat berlayar sempit terlebih dahulu tanpa media query, lalu menambahkan kompleksitas tata letak ke atas menggunakan media query `min-width` dengan penanda breakpoint infix (`sm`, `md`, `lg`, `xl`). Pendekatan Mobile-First lebih efisien dalam hal performa perangkat seluler karena peramban smartphone tidak perlu mengeksekusi dan menimpa aturan rumit desktop.",
        ),
        (
          "Mengapa kombinasi class `.col-12.col-md-4` menghasilkan 3 kartu sejajar pada layar medium dan 1 kolom pada layar mobile?",
          "Sistem grid Bootstrap membagi lebar horizontal satu kontainer `.row` menjadi 12 kolom unit. Pada layar mobile (lebar < 768px), kelas dasar `.col-12` aktif sehingga tiap elemen mengambil 12 unit grid penuh (12/12 = 1 kolom), memaksa ketiga kartu tersusun bertumpuk secara vertikal. Ketika layar mencapai breakpoint medium (lebar >= 768px), kelas `.col-md-4` mengambil alih di mana tiap kartu hanya menghabiskan 4 unit grid. Karena 12 dibagi 4 sama dengan 3, maka ketiga kartu secara otomatis tertata sejajar berdampingan secara horizontal dalam satu baris.",
        ),
        (
          "Bagaimana mekanisme kerja atribut `data-bs-toggle=\"collapse\"` dan `data-bs-target=\"#navbarNav\"` pada tombol navigasi hamburger?",
          "Atribut `data-bs-*` merupakan Data Attributes API resmi Bootstrap yang dibaca oleh pustaka `bootstrap.bundle.min.js`. Atribut `data-bs-toggle=\"collapse\"` mendaftarkan event handler klik secara otomatis pada tombol hamburger `.navbar-toggler`. Ketika tombol diklik oleh pengguna, skrip Bootstrap mencari elemen kontainer target yang memiliki ID sesuai dengan nilai `data-bs-target` (`#navbarNav`), lalu memanipulasi kelas CSS (menambahkan/menghapus kelas `.show`) dan menjalankan transisi tinggi elemen (*height animation*) secara halus untuk menampilkan atau menyembunyikan menu navigasi.",
        ),
        (
          "Mengapa berkas `style.css` pada implementasi Bootstrap tetap memerlukan deklarasi `!important` untuk menimpa warna navbar dan tombol?",
          "Pustaka inti Bootstrap telah mendefinisikan aturan pewarnaan untuk komponen bawaan seperti `.navbar-dark .navbar-nav .nav-link` dan tombol submit dengan tingkat spesifisitas selektor yang cukup tinggi dan palet warna standar framework (`#0d6efd`). Untuk mengganti warna tersebut menjadi warna brand SIMPUS-Mini (`#1d5b8a` dan `#164869`) tanpa harus menulis ulang selektor bertingkat yang sangat panjang dan rapuh, deklarasi `!important` dimanfaatkan untuk memberikan prioritas mutlak (*highest specificity override*) pada proses kalkulasi cascading CSS browser.",
        ),
      ),
    ),
    (
      subbab: "Hasil Pengujian Tampilan Responsif (Bootstrap 5)",
      deskripsi: [
        Pengujian visual antarmuka berbasis framework Bootstrap 5 dilakukan melalui peramban Google Chrome dengan memanfaatkan *Responsive Device Mode* pada tiga profil resolusi utama: Desktop (1024px), Tablet (768px), dan Mobile (375px).

        #v(1em)
        *1. Tampilan Desktop (Resolusi 1024px)* \
        Pada resolusi desktop, menu navigasi tampil membentang horizontal secara penuh di sisi kanan navbar. Tiga kartu ringkasan data statistik tertata sejajar dalam satu baris horizontal berkat sistem grid `.col-md-4` ($12 / 4 = 3$ kolom).

        #align(center)[
          #figure(
            image("../../jobsheet03-bootstrap/screenshots/ss01_bootstrap_desktop_1024px.png", width: 90%),
            caption: [Tampilan Beranda Bootstrap pada Resolusi Desktop 1024px (Grid 3 Kolom & Navbar Horizontal)]
          )
        ]

        #v(1em)
        *2. Tampilan Tablet (Resolusi 768px)* \
        Pada resolusi batas tablet (768px), breakpoint `.navbar-expand-md` mulai melipat menu navigasi menjadi tombol hamburger di pojok kanan atas, sementara grid 3 kartu statistik tetap bertahan dalam posisi horizontal yang proporsional sesuai aturan `col-md-4`.

        #align(center)[
          #figure(
            image("../../jobsheet03-bootstrap/screenshots/ss02_bootstrap_tablet_768px.png", width: 90%),
            caption: [Tampilan Beranda Bootstrap pada Resolusi Tablet 768px (Navbar Terlipat & Grid 3 Kolom)]
          )
        ]

        #v(1em)
        *3. Tampilan Mobile (Resolusi 375px - Menu Tertutup & Terbuka)* \
        Pada layar smartphone (375px), aturan `.col-12` aktif sehingga ketiga kartu statistik tersusun bertumpuk secara vertikal (1 kolom penuh). Ketika tombol hamburger diklik, modul JavaScript Bootstrap membuka menu dropdown ke bawah dengan animasi transisi yang mulus.

        #grid(
          columns: (1fr, 1fr),
          gutter: 10pt,
          figure(
            image("../../jobsheet03-bootstrap/screenshots/ss03_bootstrap_mobile_375px_menu_closed.png", width: 100%),
            caption: [Bootstrap Mobile (375px): Menu Tertutup]
          ),
          figure(
            image("../../jobsheet03-bootstrap/screenshots/ss04_bootstrap_mobile_375px_menu_opened.png", width: 100%),
            caption: [Bootstrap Mobile (375px): Menu Terbuka via JS Collapse]
          )
        )

        #v(1em)
        *4. Tampilan Tabel Responsif Bootstrap pada Mobile (Resolusi 375px)* \
        Pada halaman daftar koleksi buku (`books/list.html`), kelas bawaan `.table-responsive` membungkus elemen tabel bergaris (`.table-striped`). Saat dibuka pada layar 375px, tabel tidak menyebabkan horizontal scrolling pada keseluruhan halaman web, melainkan menyediakan scroll horizontal independen sehingga pengguna dapat menggeser tabel ke arah kanan untuk mengakses kolom Stok dan tombol aksi Edit/Hapus secara nyaman.

        #grid(
          columns: (1fr, 1fr),
          gutter: 10pt,
          figure(
            image("../../jobsheet03-bootstrap/screenshots/ss05_bootstrap_table_left.png", width: 100%),
            caption: [Tabel Bootstrap Mobile: Sisi Kiri (Nomor, Judul, Pengarang)]
          ),
          figure(
            image("../../jobsheet03-bootstrap/screenshots/ss06_bootstrap_table_scrolled.png", width: 100%),
            caption: [Tabel Bootstrap Mobile: Digeser ke Kanan (Stok & Tombol Aksi)]
          )
        )
      ],
      langkah: (),
      pertanyaan: (),
    ),
  ))
]
