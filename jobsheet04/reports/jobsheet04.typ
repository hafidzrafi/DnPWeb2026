#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 4 - UI UX DESIGN, WIREFRAME DAN USER FLOW",
  repository: "https://github.com/hafidzrafi/DnPWeb2026",
  footer_text: "Desain dan Pemrograman Web -- Jobsheet 4",
)[
  #tujuan(data: (
    "Memahami konsep dasar UI (User Interface) dan UX (User Experience) serta perbedaannya dalam rekayasa perangkat lunak web modern.",
    "Menguasai filosofi Design Before Coding untuk meminimalkan beban refactoring dan kesalahan alur logika sistem sebelum fase implementasi teknis.",
    "Menganalisis dan membaca konvensi simbol semantik Wireframe berbasis teks (ASCII) dan visual mockup sebagai cetak biru tata letak antarmuka.",
    "Memetakan User Flow (alur pengguna) komprehensif untuk transaksi peminjaman dan pengembalian buku pada Sistem Informasi Perpustakaan Mini (SIMPUS-Mini).",
    "Mengidentifikasi aktor sistem (Tamu vs Petugas) serta batasan hak akses (otorisasi fitur) pada arsitektur aplikasi perpustakaan.",
    "Menganalisis konsistensi arsitektur cetak biru antarmuka baru terhadap komponen CSS Grid, Flexbox navbar, dan palet warna yang telah dibangun pada Jobsheet 1 hingga Jobsheet 3.",
    "Mengidentifikasi dan mendokumentasikan penanganan kasus batas (edge cases) seperti stok buku habis dan tunggakan pengembalian sejak tahap perancangan awal.",
    [Menyimpan dan mengelola seluruh source code serta dokumentasi rancangan pada repositori GitHub: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Konsep Dasar UI/UX Design dan Tahap Perancangan Perangkat Lunak",
      deskripsi: [
        Pada praktikum Jobsheet 4 ini, fokus pembelajaran berada pada fase perancangan sistem (*UI/UX design phase*) untuk aplikasi Sistem Informasi Perpustakaan Mini (SIMPUS-Mini). Berbeda dengan Jobsheet 1 hingga 3 yang berfokus langsung pada konstruksi kode HTML dan CSS, Jobsheet 4 merupakan *design and planning milestone* yang secara metodologis tidak menambahkan kode fungsional baru, melainkan menyusun fondasi arsitektur antarmuka dan alur transaksi yang akan diimplementasikan pada Jobsheet 5 (JavaScript) serta Jobsheet backend berikutnya.

        === 1.1 Perbedaan Mendasar UI dan UX
        Dalam rekayasa antarmuka web modern, UI (*User Interface*) dan UX (*User Experience*) adalah dua domain yang saling melengkapi namun memiliki fokus tujuan yang berbeda:

        #table(
          columns: (1.2fr, 2.2fr, 2.6fr),
          stroke: 0.5pt + rgb("#cbd5e1"),
          inset: 7pt,
          fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else { none },
          align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
          table.header(
            [*Dimensi*], [*User Interface (UI)*], [*User Experience (UX)*]
          ),
          [Definisi], [Antarmuka visual dan komponen fisik yang berinteraksi langsung dengan mata pengguna.], [Pengalaman, kemudahan, dan efisiensi alur yang dirasakan pengguna saat mencapai tujuannya.],
          [Fokus Utama], [Warna, tipografi, hierarki visual, kontras, tata letak, dan gaya tombol.], [Struktur navigasi, logika sekuensial, pencegahan kesalahan input, dan alur kerja (*flow*).],
          [Analogi Toko], [Penataan etalase toko, kombinasi pencahayaan, dekorasi rak, dan kebersihan visual toko.], [Kemudahan pelanggan menemukan barang yang dicari, kejelasan petunjuk arah, dan kecepatan antrean kasir.],
          [Penerapan di SIMPUS], [Warna brand biru `#1d5b8a`, kartu bayangan `.card`, tabel belang, dan tombol aksi semantik.], [Alur 8 langkah peminjaman buku, filter otomatis stok habis, dan kemudahan pencarian transaksi pengembalian.],
        )

        === 1.2 Filosofi Design Before Coding
        Dalam siklus hidup pengembangan perangkat lunak (*Software Development Life Cycle*), biaya perbaikan (*cost of change*) meningkat secara eksponensial seiring berjalannya fase proyek. Mengubah rancangan alur pada selembar kertas atau dokumen spesifikasi teks hanya membutuhkan waktu hitungan menit tanpa biaya komputasi. Sebaliknya, mengubah alur sistem setelah kode HTML, penataan CSS, manipulasi DOM JavaScript, dan tabel basis data selesai dibuat akan memicu penulisan ulang kode (*code refactoring*) yang masif dan rentan memunculkan *bug* regresi.

        Oleh karena itu, penyusunan berkas cetak biru `docs/wireframe.md` pada Jobsheet 4 ini menjadi peta jalan krusial agar pengembang memahami dengan pasti apa yang akan dibangun sebelum menulis sebaris kode pun.

        === 1.3 Dua Pilar Perancangan: Wireframe vs User Flow
        Dokumen perancangan pada Jobsheet 4 memadukan dua instrumen utama:
        - *Wireframe*: Sketsa struktural halaman web tanpa memperhitungkan detail ornamen grafis atau visual aset. Wireframe menjawab pertanyaan mendasar: *"Komponen apa saja yang ada pada halaman ini dan di mana posisinya?"*.
        - *User Flow*: Diagram langkah demi langkah yang menunjukkan perpindahan pengguna antar layar untuk menuntaskan suatu proses bisnis tertentu. User flow menjawab pertanyaan: *"Bagaimana urutan tindakan yang harus dilalui pengguna untuk menyelesaikan tugas ini?"*.
      ],
      langkah: (
        "Menganalisis batasan arsitektur aplikasi SIMPUS-Mini yang telah berjalan pada Jobsheet 1 hingga Jobsheet 3 (Beranda, Daftar Buku, Tambah Buku, Daftar Anggota, dan Tambah Anggota).",
        "Mengidentifikasi kebutuhan modul transaksi yang belum terfasilitasi pada kode eksisting, mencakup modul Autentikasi Petugas, Transaksi Peminjaman Baru, Transaksi Pengembalian, serta Riwayat Peminjaman.",
        "Mempelajari dokumen acuan `docs/wireframe.md` dan infografis resmi untuk memahami pemisahan peran antara elemen antarmuka visual (UI) dan alur logika pengguna (UX).",
      ),
      pertanyaan: (),
    ),
    (
      subbab: "Pemetaan Aktor Sistem dan Batasan Hak Akses (Otorisasi)",
      deskripsi: [
        Aplikasi perpustakaan tidak dapat memperlakukan setiap pengunjung dengan tingkat akses yang seragam. SIMPUS-Mini membagi pengguna ke dalam dua entitas aktor dengan batas tanggung jawab dan otorisasi yang tegas:

        === 2.1 Definisi Aktor Sistem
        1. *Tamu (Guest/Public)*: Pengunjung perpustakaan umum yang tidak memiliki kredensial akun. Aktor ini hanya memiliki hak baca (*read-only*) terhadap katalog koleksi buku publik dan ringkasan statistik beranda tanpa kemampuan memodifikasi data.
        2. *Petugas (Librarian/Administrator)*: Staf perpustakaan yang memiliki akun terverifikasi. Petugas wajib melakukan proses autentikasi (login) untuk mengelola data master buku, master anggota, serta memproses transaksi sirkulasi peminjaman dan pengembalian.

        === 2.2 Matriks Hak Akses (Otorisasi Fitur)
        Berdasarkan rancangan Jobsheet 4, pembagian hak akses fitur dipetakan ke dalam matriks berikut:

        #table(
          columns: (2.2fr, 1.4fr, 1.4fr),
          stroke: 0.5pt + rgb("#cbd5e1"),
          inset: 7pt,
          fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else { none },
          align: (col, row) => if row == 0 { center + horizon } else { (if col == 0 { left + horizon } else { center + horizon }) },
          table.header(
            [*Modul Fitur Aplikasi*], [*Aktor Tamu*], [*Aktor Petugas*]
          ),
          [Melihat Beranda & Statistik Publik], [Diizinkan (Ya)], [Diizinkan (Ya)],
          [Melihat Katalog & Detail Koleksi Buku], [Diizinkan (Ya)], [Diizinkan (Ya)],
          [Mengakses Formulir Login Petugas], [Diizinkan (Ya)], [Diizinkan (Ya)],
          [Menambah, Mengedit, Menghapus Buku (CRUD)], [Ditolak (Tidak)], [Diizinkan (Ya)],
          [Menambah, Mengedit, Menghapus Anggota (CRUD)], [Ditolak (Tidak)], [Diizinkan (Ya)],
          [Mengakses Dashboard Khusus Petugas], [Ditolak (Tidak)], [Diizinkan (Ya)],
          [Memproses Transaksi Peminjaman Baru], [Ditolak (Tidak)], [Diizinkan (Ya)],
          [Memproses Pengembalian Buku & Pemulihan Stok], [Ditolak (Tidak)], [Diizinkan (Ya)],
          [Melihat Riwayat Peminjaman Lengkap per Anggota], [Ditolak (Tidak)], [Diizinkan (Ya)],
        )

        === 2.3 Implikasi Desain terhadap Komponen Navigasi Header
        Perbedaan hak akses ini mempengaruhi struktur antarmuka bilah navigasi (`<header>`). Pada kondisi pengguna belum login (Tamu), navbar hanya menyajikan tautan publik: `Beranda`, `Daftar Buku`, dan tombol `Login`. Setelah Petugas berhasil login, komponen navbar secara dinamis memunculkan menu `Peminjaman`, menu master data, serta indikator profil nama petugas yang sedang aktif disertai tombol `Logout`.
      ],
      langkah: (
        "Mengklasifikasikan peran pengguna aplikasi ke dalam dua kategori entitas utama: Tamu dan Petugas.",
        "Menyusun matriks kontrol akses fungsional untuk mengamankan fitur-fitur transaksi sensitif agar tidak dapat diakses sembarangan oleh publik.",
        "Merancang struktur fleksibel pada header navigasi web yang mampu mengadaptasi status sesi pengguna secara dinamis.",
      ),
      pertanyaan: (),
    ),
    (
      subbab: "Analisis User Flow Proses Bisnis Peminjaman dan Pengembalian",
      deskripsi: [
        User flow memodelkan urutan interaksi sekuensial yang harus dilalui Petugas untuk menuntaskan transaksi perpustakaan tanpa celah kesalahan.

        === 3.1 User Flow: Transaksi Peminjaman Buku (8 Tahap)
        Proses peminjaman buku dirancang melalui 8 tahapan terstruktur:
        ```text
        [1. Petugas Login] 
             ↓
        [2. Buka Dashboard Petugas] 
             ↓
        [3. Pilih Menu "Peminjaman Baru"] 
             ↓
        [4. Pilih Anggota Terdaftar dari Dropdown] 
             ↓
        [5. Pilih Koleksi Buku (Kondisi: Stok Fisik > 0)] 
             ↓
        [6. Klik Tombol "Simpan Peminjaman"] 
             ↓
        [7. Sistem Mengurangi Stok Buku (-1) & Mencatat Tanggal Transaksi] 
             ↓
        [8. Kembali ke Dashboard Petugas dengan Ringkasan Terkini]
        ```

        === 3.2 User Flow: Transaksi Pengembalian Buku (6 Tahap)
        Proses pengembalian buku dirancang efisien agar petugas dapat menyelesaikan sirkulasi dalam waktu singkat:
        ```text
        [1. Dashboard Petugas] 
             ↓
        [2. Buka Menu "Pengembalian"] 
             ↓
        [3. Cari Transaksi Aktif Berdasarkan Nama Anggota atau Judul Buku] 
             ↓
        [4. Klik Tombol Aksi "Kembalikan" pada Baris yang Sesuai] 
             ↓
        [5. Sistem Memulihkan Stok Buku (+1) & Mengubah Status Menjadi "Selesai"] 
             ↓
        [6. Kembali ke Dashboard dengan Status Inventaris Terkini]
        ```

        === 3.3 Penanganan Kasus Batas (Edge Cases) dan Integritas Data
        Rancangan sistem mencatat aturan bisnis kritis (*business rules*) sejak fase wireframe:
        1. *Filter Stok Nol (`stok > 0`)*: Buku dengan kuantitas stok sama dengan 0 tidak boleh dapat dipilih pada elemen `<select>` formulir peminjaman untuk mencegah peminjaman fiktif.
        2. *Validasi Status Transaksi*: Tombol aksi "Kembalikan" hanya aktif pada transaksi yang berstatus `Dipinjam`. Transaksi yang sudah `Selesai` dinonaktifkan.
        3. *Validasi Tunggakan Anggota*: Anggota yang memiliki catatan keterlambatan atau denda aktif ditandai secara visual agar petugas dapat menahan peminjaman baru sampai kewajiban diselesaikan.
      ],
      langkah: (
        "Memetakan alur peminjaman buku ke dalam delapan langkah sekuensial dari autentikasi hingga pengurangan stok otomatis.",
        "Memetakan alur pengembalian buku ke dalam enam langkah cepat dari pencarian transaksi aktif hingga pemulihan kuantitas stok fisik.",
        "Mendefinisikan dan mencatat aturan validasi *edge cases* untuk memastikan integritas data transaksi perpustakaan terjaga.",
      ),
      pertanyaan: (),
    ),
    (
      subbab: "Rancangan Wireframe Antarmuka Aplikasi SIMPUS-Mini",
      deskripsi: [
        Wireframe pada berkas `docs/wireframe.md` memanfaatkan konvensi notasi teks ASCII terstandar untuk memvisualisasikan arsitektur tata letak lima layar utama yang akan dibangun.

        === 4.1 Notasi Simbol Semantik Wireframe
        Konvensi simbol yang diterapkan mencerminkan padanan elemen HTML5:
        - `+-----+` : Batas kontainer pembungkus utama (`<main>`, `<section>`, atau `.card`).
        - `[ Button ]` : Komponen tombol aksi interaktif (`<button>` atau `.btn`).
        - `[______________]` : Bidang isian teks tunggal (`<input type="text">` atau `<input type="password">`).
        - `[ dropdown v ]` : Komponen pemilih opsi bertingkat (`<select>` dan `<option>`).
        - `|---|` : Garis batas pemisah kolom atau baris tabel data (`<table>`, `<tr>`, `<td>`).

        === 4.2 Analisis dan Spesifikasi Wireframe 5 Layar Utama
        1. *Wireframe Halaman Login Petugas*:
           Tata letak dirancang ringkas di tengah area pandang (*centered card*) untuk memusatkan fokus. Terdiri dari bidang input teks Username, bidang Password dengan tipe tersembunyi (*masked input*), tombol "Masuk", dan tautan bantuan pendaftaran akun.
        2. *Wireframe Dashboard Petugas*:
           Menampilkan bilah status profil petugas pada header, tiga kartu ringkasan data statistik (Total Buku, Total Anggota, Sedang Dipinjam), blok tombol aksi cepat (*Quick Actions* untuk Peminjaman dan Pengembalian), serta tabel daftar transaksi terbaru.
        3. *Wireframe Form Peminjaman Buku*:
           Menyajikan dropdown dinamis pemilih anggota, dropdown koleksi buku yang telah terfilter (`stok > 0`), input tanggal otomatis hari ini (*default current date*), serta tombol submit "Simpan Peminjaman".
        4. *Wireframe Form Pengembalian Buku*:
           Menyediakan bidang pencarian instan transaksi aktif yang langsung memfilter baris tabel peminjaman, dilengkapi tombol aksi fungsional "Kembalikan" di setiap baris data.
        5. *Wireframe Riwayat Peminjaman per Anggota*:
           Tabel komprehensif yang menampilkan rekam jejak literasi anggota, mencakup nama buku, tanggal pinjam, batas tanggal kembali, serta badge penanda status (`Dipinjam` dengan warna oranye, `Selesai` dengan warna hijau).

        === 4.3 Keterhubungan dengan Arsitektur CSS Eksisting
        Seluruh rancangan kawat ini dirancang dengan prinsip keberlanjutan kode (*code reusability*):
        - Komponen kartu statistik pada Dashboard Petugas menggunakan kembali aturan CSS Grid (`repeat(3, 1fr)`) yang telah dibangun pada Jobsheet 2 dan 3.
        - Komponen tabel dan tombol aksi memanfaatkan pola `.table-responsive` dan selektor tombol yang sudah ada di `assets/css/style.css`.
        - Palet warna identitas korporat tetap konsisten menggunakan warna biru `#1d5b8a` untuk header dan tombol utama, menjaga keselarasan estetika merek aplikasi.
      ],
      langkah: (
        "Menyusun cetak biru tata letak antarmuka ke dalam dokumen `docs/wireframe.md` menggunakan notasi ASCII.",
        "Memetakan komponen simbol wireframe ke tag semantik HTML5 yang sesuai untuk memudahkan implementasi kode.",
        "Memverifikasi keselarasan konsep wireframe dengan berkas lembar gaya `assets/css/style.css` agar tidak memerlukan perombakan desain mendasar.",
      ),
      pertanyaan: (),
    ),
    (
      subbab: "Visualisasi Cetak Biru Antarmuka (Infografis Resmi SIMPUS-Mini)",
      deskripsi: [
        Sebagai bentuk visualisasi komprehensif, seluruh rancangan aktor sistem, alur pengguna (*user flow*), mockup wireframe lima layar, pedoman konsistensi desain, serta aturan validasi edge case dirangkum ke dalam satu infografis resmi arsitektur sistem SIMPUS-Mini berikut:

        #v(1em)
        #align(center)[
          #figure(
            image("Infografis.png", width: 92%),
            caption: [Infografis Lengkap Wireframe, User Flow, dan Arsitektur Antarmuka SIMPUS-Mini (Jobsheet 4)]
          )
        ]
        #v(1em)

        Infografis di atas menjadi acuan standar baku bagi tim pengembang dalam merealisasikan interaktivitas skrip pada modul praktikum berikutnya (Jobsheet 5 dan seterusnya).
      ],
      langkah: (),
      pertanyaan: (
        (
          "Mengapa perancangan UI/UX (khususnya Wireframe dan User Flow) sangat krusial dilakukan sebelum implementasi kode pada proyek perangkat lunak?",
          "Perancangan UI/UX sebelum penulisan kode sangat krusial karena kurva biaya perubahan (*cost of change*) pada siklus hidup perangkat lunak meningkat secara signifikan di fase implementasi. Dengan menyusun wireframe dan user flow terlebih dahulu, tim pengembang dapat memvalidasi alur proses bisnis, menemukan celah logika, dan menyepakati arsitektur tata letak dalam bentuk dokumen rancangan yang murah untuk direvisi, sehingga mencegah pemborosan waktu akibat *refactoring* massal kode HTML, CSS, JavaScript, maupun query basis data di kemudian hari.",
        ),
        (
          "Apa perbedaan mendasar antara Wireframe dan User Flow, dan mengapa kedua instrumen perancangan ini saling melengkapi?",
          "Perbedaan mendasarnya terletak pada sudut pandang analisis: Wireframe berfokus pada dimensi statis dan spasial antarmuka (*'Komponen apa saja yang ada di satu layar dan di mana posisinya?'*), sedangkan User Flow berfokus pada dimensi temporal dan logika sekuensial (*'Bagaimana urutan perpindahan antar halaman yang harus dilalui pengguna untuk menuntaskan suatu proses?'*). Keduanya saling melengkapi karena wireframe tanpa user flow akan membuat pengembang bingung menentukan pemicu navigasi antar halaman, sedangkan user flow tanpa wireframe membuat pengembang tidak memiliki panduan mengenai elemen kontrol apa yang harus disediakan pada masing-masing langkah.",
        ),
        (
          "Bagaimana rancangan wireframe pada Jobsheet 4 ini mempertahankan konsistensi visual dan efisiensi arsitektur kode dengan apa yang telah dibangun pada Jobsheet 1 hingga Jobsheet 3?",
          "Rancangan wireframe Jobsheet 4 secara ketat mengadopsi pola komponen yang telah distandarisasi pada berkas `assets/css/style.css` sejak Jobsheet 1 hingga 3. Sebagai contoh, kartu ringkasan Dashboard Petugas menggunakan struktur CSS Grid tiga kolom yang identik dengan kartu beranda sebelumnya; komponen tabel transaksi sirkulasi tetap mengandalkan pembungkus responsif `.table-responsive` dan pewarnaan belang; serta seluruh tombol submit dan aksen header tetap mengusung warna identitas `#1d5b8a`. Dengan pendekatan ini, saat halaman baru dikoding pada Jobsheet berikutnya, pengembang dapat langsung menggunakan kembali (*reuse*) deklarasi CSS yang sudah ada tanpa perlu menulis ulang styling dari nol.",
        ),
        (
          "Mengapa pencatatan edge case (seperti stok buku habis atau tunggakan anggota) wajib dilakukan sejak tahap perancangan awal dan bukan saat fase koding?",
          "Pencatatan *edge cases* wajib dilakukan sejak tahap perancangan karena kondisi-kondisi batas tersebut secara langsung mendikte kebutuhan elemen pada antarmuka dan alur navigasi pengguna. Contohnya, aturan 'buku stok 0 tidak boleh dipinjam' memerlukan penambahan logika filter visual pada dropdown formulir, sedangkan 'anggota bertunggakan' memerlukan komponen notifikasi peringatan (*warning badge*). Jika kasus-kasus khusus ini baru disadari saat fase koding, pengembang terpaksa merombak ulang struktur formulir, query data, dan alur validasi yang sebelumnya sudah dirancang, yang berpotensi tinggi memicu *bug* integritas data.",
        ),
      ),
    ),
  ))
]
