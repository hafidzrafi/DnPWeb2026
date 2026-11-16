#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 13 - DEPLOYMENT DAN DOKUMENTASI",
  repository: "https://github.com/hafidzrafi/DnPWeb2026",
  footer_text: "Desain dan Pemrograman Web -- Jobsheet 13",
)[
  #tujuan(data: (
    [Memindahkan kredensial database dari kode halaman ke `includes/config.php` yang membaca environment variable.],
    [Menghubungkan `includes/koneksi.php` ke `config.php` dan memakai `sslmode` yang dapat diatur per lingkungan.],
    [Membuktikan override konfigurasi dengan menjalankan aplikasi terhadap database berbeda tanpa mengubah satu baris kode.],
    [Menyusun dokumentasi proyek: README dengan ERD dan matriks fitur, serta manual pengguna dengan tangkapan layar asli.],
    [Memverifikasi seluruh berkas PHP dengan `php -l` dan menjalankan alur instalasi dari database kosong.],
    [Menyimpan seluruh source code pekerjaan pada repositori GitHub resmi: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Kredensial yang Menempel pada Kode",
      deskripsi: [
        Sebelum jobsheet ini, `includes/koneksi.php` memuat kredensial langsung di dalam berkasnya:

        ```php
        $host = "localhost";
        $port = "5432";
        $db   = "simpus_mini";
        $user = "postgres";
        $pass = "postgres";
        ```

        Pola itu punya dua akibat. Pertama, memindahkan aplikasi ke hosting berarti mengubah berkas
        yang sama yang dilacak Git, sehingga perubahan kredensial bercampur dengan perubahan kode.
        Kedua, berkas itu harus dikecualikan dari repositori publik, dan begitu dikecualikan,
        siapa pun yang meng-clone proyek tidak punya berkas koneksi sama sekali.

        === Memisahkan Konfigurasi dari Koneksi

        Perbaikan yang dipakai bukan menyembunyikan berkas, melainkan memisahkan dua hal yang
        berbeda sifat. `includes/config.php` menyimpan nilai yang berbeda antar lingkungan dan
        aman di-commit karena isinya hanya pembacaan environment variable:

        ```php
        return [
            'db_host' => getenv('DB_HOST') ?: 'localhost',
            'db_port' => getenv('DB_PORT') ?: '5432',
            'db_name' => getenv('DB_NAME') ?: 'simpus_mini',
            'db_user' => getenv('DB_USER') ?: 'postgres',
            'db_pass' => getenv('DB_PASS') ?: 'postgres',
        ];
        ```

        Operator `?:` membuat environment variable menang bila ada dan tidak kosong, lalu jatuh ke
        default lokal bila tidak. `getenv()` mengembalikan `false` untuk variable yang tidak diatur,
        dan `false` bernilai salah dalam kondisi `?:`, sehingga fallback bekerja tanpa pemeriksaan
        tambahan.

        `includes/koneksi.php` kemudian hanya berisi logika koneksi:

        ```php
        $config = require __DIR__ . '/config.php';

        $ssl_mode = getenv('DB_SSLMODE') ?: 'require';

        $dsn = "pgsql:host={$config['db_host']};"
             . "port={$config['db_port']};"
             . "dbname={$config['db_name']};"
             . "sslmode={$ssl_mode}";

        $pdo = new PDO($dsn, $config['db_user'], $config['db_pass'], [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
        ```

        === Mengapa `sslmode` Ikut Dipisahkan

        PostgreSQL lokal bawaan Laragon berjalan dengan `ssl = off`. Bila `sslmode` ditulis mati
        sebagai `require`, pengembangan lokal gagal dengan pesan:

        ```text
        SQLSTATE[08006] [7] connection to server at "localhost" (::1),
        port 5432 failed: server does not support SSL, but SSL was required
        ```

        Bila ditulis `disable`, hosting yang mewajibkan TLS menolak koneksi. Karena itu nilainya
        dijadikan environment variable dengan default `require` (kebutuhan produksi) dan
        `DB_SSLMODE=disable` untuk lokal. Ini bukan nilai rahasia, hanya perbedaan lingkungan.

        === Kegagalan Koneksi Tidak Lagi Bocor

        Blok `catch` sebelumnya menyimpan pesan ke `$db_error` tanpa pernah dipakai, sementara
        `PDOException` yang tidak tertangani mencetak detail koneksi ke halaman. Versi baru mencatat
        pesan asli ke log server dan menghentikan halaman dengan pesan generik:

        ```php
        } catch (PDOException $e) {
            error_log('SIMPUS-Mini koneksi: ' . $e->getMessage());
            http_response_code(500);
            exit('Koneksi database tidak tersedia. Silakan coba kembali.');
        }
        ```

        Pengujian: menjalankan server tanpa `DB_SSLMODE` lalu mengirim POST login menghasilkan
        HTTP 500 dengan teks "Koneksi database tidak tersedia. Silakan coba kembali.", sedangkan
        log server memuat pesan `SQLSTATE[08006]` lengkap. Detail teknis tetap tersedia bagi
        pengembang, tetapi tidak lagi dikirim ke browser.
      ],
      langkah: (
        [Membuat `includes/config.php` yang mengembalikan array konfigurasi dari `getenv()`.],
        [Menulis ulang `includes/koneksi.php` agar menyusun DSN dari array tersebut.],
        [Menambahkan `DB_SSLMODE` dengan default `require` dan memakai `disable` saat pengembangan lokal.],
        [Menghapus variabel `$db_error` yang tidak pernah dibaca dan memindahkan pesan exception ke `error_log()`.],
        [Menjalankan server tanpa `DB_SSLMODE` dan memastikan respons 500 tanpa detail koneksi.],
      ),
      pertanyaan: (
        (
          [Mengapa `config.php` aman di-commit sedangkan kredensial asli tidak?],
          [Karena isi berkas itu hanya instruksi membaca environment variable beserta default lokal yang tidak dipakai di produksi. Rahasianya hidup di environment server, bukan di repositori, sehingga berkas yang sama dapat dipakai di mesin mana pun tanpa perubahan.]
        ),
        (
          [Mengapa `getenv()` dipakai, bukan berkas `.env`?],
          [Karena `getenv()` adalah mekanisme bawaan PHP yang tidak menambah dependensi. Berkas `.env` memerlukan pustaka pembaca dan satu berkas lagi yang harus dijaga agar tidak ikut ter-commit. Untuk enam nilai konfigurasi, lapisan tambahan itu belum memberi keuntungan.]
        ),
        (
          [Apa risiko memberi default `'postgres'` pada `db_user` dan `db_pass`?],
          [Bila operator lupa mengatur environment variable di produksi, aplikasi mencoba masuk dengan kredensial default dan gagal koneksi, bukan diam-diam memakai akun lemah. Kegagalan yang terlihat lebih aman daripada keberhasilan yang tidak disadari.]
        ),
      ),
    ),

    (
      subbab: "Percobaan 2: Membuktikan Override Konfigurasi",
      deskripsi: [
        Konfigurasi yang hanya "terlihat benar" belum membuktikan apa pun. Pembuktian dilakukan
        dengan menyiapkan database kedua yang benar-benar terpisah, lalu menjalankan aplikasi yang
        sama terhadap database itu tanpa menyentuh kode.

        === Menyiapkan Database Alternatif

        ```bash
        createdb simpus_laprak_alt
        psql -d simpus_laprak_alt -f jobsheet13/src/sql/01_buku_anggota.sql
        psql -d simpus_laprak_alt -f jobsheet13/src/sql/02_users.sql
        psql -d simpus_laprak_alt -f jobsheet13/src/sql/03_peminjaman.sql
        ```

        Setelah ketiga skrip berjalan, database berisi tiga tabel kosong: `buku` 0 baris,
        `users` 0 baris, `peminjaman` 0 baris. Angka itu menjadi pembeda terhadap database utama
        yang berisi dua buku dan dua anggota.

        === Menjalankan Aplikasi terhadap Database Itu

        ```bash
        DB_NAME=simpus_laprak_alt DB_SSLMODE=disable php -S 127.0.0.1:8001 -t jobsheet13/src/public
        ```

        Akun petugas didaftarkan lewat halaman registrasi, lalu login dilakukan seperti biasa.
        Dashboard yang muncul menampilkan seluruh statistik bernilai 0 dan nama petugas dari
        database baru.

        #align(center)[#block(breakable: false)[
          #image("ss02_override_db_name_dashboard.png", width: 85%)
          *Gambar 2.1:* Dashboard pada `DB_NAME=simpus_laprak_alt` Menampilkan Database Kosong.
        ]]

        Statistik nol itu bukan kegagalan tampilan, melainkan buktinya: kode yang sama, dijalankan
        pada port yang sama dengan kode sumber yang sama, membaca database yang berbeda hanya karena
        satu environment variable berubah. Tidak ada satu baris pun yang diedit di antara kedua
        eksekusi.

        === Yang Tidak Berubah

        Path CSS, JavaScript, tautan navbar, dan redirect login tetap bekerja pada port 8001.
        Perhitungan path di `includes/header.php` dan `includes/auth.php` hanya bergantung pada
        kedalaman folder halaman, bukan pada nama host atau port, sehingga menjalankan aplikasi di
        port lain atau di bawah subdirektori tidak memerlukan perubahan konfigurasi tambahan.
      ],
      langkah: (
        [Membuat database `simpus_laprak_alt` dan menjalankan ketiga skrip SQL berurutan.],
        [Memeriksa jumlah baris tiap tabel untuk memastikan database benar-benar kosong.],
        [Menjalankan server dengan `DB_NAME=simpus_laprak_alt DB_SSLMODE=disable` pada port 8001.],
        [Mendaftarkan akun petugas baru dan login lewat browser.],
        [Mengambil tangkapan layar dashboard dan membandingkan angkanya dengan database utama.],
      ),
      pertanyaan: (
        (
          [Mengapa pembuktian memakai database kedua, bukan sekadar mengganti nama database di kode?],
          [Mengganti nilai di kode membuktikan bahwa kode dapat diubah, bukan bahwa konfigurasi bekerja. Database kedua memaksa jalur pembacaan environment variable benar-benar dieksekusi, dan hasilnya terlihat pada data yang berbeda.]
        ),
        (
          [Mengapa akun petugas harus didaftarkan ulang di database alternatif?],
          [Karena tabel `users` ikut kosong. Sesi login memeriksa tabel `users` di database yang sedang dipakai, jadi akun dari database utama tidak dikenali. Ini juga menegaskan bahwa autentikasi memang membaca database yang dikonfigurasi, bukan nilai yang tersimpan di tempat lain.]
        ),
        (
          [Apa yang terjadi bila `DB_NAME` diisi nama database yang tidak ada?],
          [`PDO` melempar `PDOException` saat koneksi dibuka. Blok `catch` mencatatnya ke log dan menghentikan halaman dengan HTTP 500 serta pesan generik, sehingga pengunjung tidak melihat nama database yang dicoba.]
        ),
      ),
    ),

    (
      subbab: "Percobaan 3: Dokumentasi Proyek",
      deskripsi: [
        Dokumentasi pada jobsheet ini terdiri atas tiga berkas dengan pembaca yang berbeda. README
        ditujukan untuk orang yang akan menjalankan aplikasi, `docs/manual-pengguna.md` untuk
        petugas perpustakaan yang memakainya, dan `docs/security-checklist.md` untuk pengembang
        berikutnya yang mengaudit keamanan.

        === README: Skema, Peran, dan Instalasi

        README memuat empat tabel dalam satu diagram teks agar relasi terbaca tanpa membuka berkas
        SQL. Diagram itu menyebut tipe kolom, kunci primer, dan arah foreign key, termasuk keputusan
        bahwa `peminjaman` tidak memakai `ON DELETE CASCADE`.

        Matriks fitur memisahkan apa yang boleh dilakukan tamu dan petugas. Pemisahan ini penting
        karena guard login dihitung dari nama folder halaman, sehingga menambah modul baru selalu
        menuntut pembaruan daftar folder di `includes/auth.php` dan `includes/header.php`.

        === Manual Pengguna: Tangkapan Layar Asli

        Manual pengguna tidak memakai penanda `[Screenshot: ...]` seperti draf. Setiap langkah
        dijalankan pada server `php -S` dengan PostgreSQL lokal, lalu tangkapan layarnya disimpan di
        `docs/img/` dan dirujuk langsung:

        ```markdown
        ![Form peminjaman](img/ss08_form_peminjaman.png)
        ```

        Sebelas gambar diambil dengan urutan yang sama seperti urutan langkah: registrasi, login,
        navbar setelah login, tambah buku, daftar buku, tambah anggota, daftar anggota, form
        peminjaman, daftar pengembalian, riwayat, dan keadaan setelah logout.

        #align(center)[#block(breakable: false)[
          #image("ss03_navbar_setelah_login.png", width: 85%)
          *Gambar 3.1:* Navbar Setelah Login, Gambar yang Dirujuk Manual Pengguna.
        ]]

        Satu perbedaan antara draf jobsheet dan aplikasi dicatat dan diikuti aplikasi, bukan
        sebaliknya. Draf menyebut riwayat disaring dengan memilih anggota lalu menekan tombol
        "Tampilkan", sedangkan halaman yang sudah dibangun menyaring langsung saat pilihan berubah.
        Manual menjelaskan perilaku yang benar-benar ada, karena manual yang tidak cocok dengan
        aplikasi lebih membingungkan daripada manual yang tidak lengkap.

        === Struktur Folder di Dokumentasi

        README mencantumkan struktur folder beserta satu baris keterangan per direktori. Tujuannya
        agar pembaca dapat menemukan berkas yang harus diubah saat menambah modul: konfigurasi di
        `includes/`, skema di `sql/`, dan dokumentasi di `docs/`.

        Nama folder modul memakai `books/` dan `members/`, bukan `buku/` dan `anggota/` seperti pada
        diagram struktur di jobsheet ini. Nama Inggris itu dipakai sejak Jobsheet 1 dan dipertahankan
        sampai jobsheet terakhir, sehingga seluruh tautan, guard login di `includes/auth.php`, dan
        tangkapan layar pada laporan-laporan sebelumnya menunjuk path yang sama. Mengganti nama folder
        pada tahap ini akan membuat tangkapan layar yang sudah dilampirkan menunjuk URL yang tidak
        lagi ada.

        === Document Root yang Berbeda dari Jobsheet

        Jobsheet menjalankan aplikasi dengan `php -S localhost:8000` dari folder aplikasi, sehingga
        seluruh isi folder itu dapat diminta lewat HTTP. Susunan di sini memindahkan berkas publik ke
        `public/` dan meminta server diarahkan ke sana. Perbedaannya bukan pilihan gaya: perintah
        jobsheet dijalankan apa adanya pada susunan ini menghasilkan HTTP 404 untuk `/index.php`
        sekaligus HTTP 200 untuk `/sql/01_buku_anggota.sql`, artinya skema dan isi `includes/`
        terbaca dari browser sementara aplikasinya sendiri tidak dapat dibuka.

        Karena itu README mencantumkan `-t public` pada perintah server, dan `includes/`, `sql/`,
        serta `docs/` berada satu tingkat di atas document root. Konsekuensinya, perintah pada
        jobsheet tidak dipakai apa adanya; perintah yang benar ada di README dan di bagian
        Instalasi laporan ini.
      ],
      langkah: (
        [Menulis ulang `README.md` dengan diagram ERD, matriks fitur per peran, langkah instalasi, dan tabel environment variable.],
        [Menjalankan perintah jobsheet `php -S` tanpa `-t public` untuk memastikan susunan ini memang memerlukan document root terpisah, lalu mencatat hasilnya.],
        [Menjalankan setiap langkah manual pengguna pada server `jobsheet13/src/public` dan mengambil tangkapan layar.],
        [Menyimpan gambar ke `docs/img/` dengan nama yang mengikuti nomor langkah, lalu merujuknya dari markdown.],
        [Memeriksa setiap tautan gambar menunjuk berkas yang ada.],
        [Menyesuaikan kalimat manual pada bagian riwayat agar sesuai perilaku filter yang benar-benar dipakai.],
      ),
      pertanyaan: (
        (
          [Mengapa manual pengguna memakai tangkapan layar asli, bukan penanda teks?],
          [Karena pembaca manual adalah pengguna akhir yang mencocokkan tampilan di layar dengan gambar. Penanda teks memaksa mereka menerjemahkan deskripsi menjadi tampilan, dan tidak menunjukkan apakah dokumen pernah diverifikasi terhadap aplikasi yang sebenarnya.]
        ),
        (
          [Mengapa README mencantumkan tabel environment variable lengkap dengan default?],
          [Karena operator perlu tahu nilai apa yang dipakai bila variable tidak diatur. Tanpa kolom default, satu-satunya cara mengetahuinya adalah membaca kode, dan kesalahan konfigurasi baru terlihat setelah aplikasi gagal koneksi.]
        ),
        (
          [Mengapa dokumentasi tidak memuat bagian roadmap atau rencana pengembangan?],
          [Karena proyek ini berhenti pada lingkup jobsheet. Rencana yang tidak punya pemilik dan tenggat hanya menambah bagian yang harus diperbarui tanpa ada yang memperbaruinya, dan pembaca tidak dapat membedakan mana yang sudah ada dan mana yang belum.]
        ),
      ),
    ),
  ))

  #tugas(data: (
    (
      subbab: "Verifikasi Sintaks dan Instalasi dari Nol",
      konten: [
        Seluruh berkas PHP diperiksa dengan `php -l`. Perintah ini membaca setiap berkas dan
        melaporkan kesalahan sintaks tanpa menjalankannya:

        ```bash
        find jobsheet13/src -name '*.php' -exec php -l {} \; | grep -v "No syntax errors"
        ```

        Perintah tidak menghasilkan output, yang berarti setiap berkas mengembalikan
        "No syntax errors". Pemeriksaan ini tidak membuktikan perilaku aplikasi, hanya bahwa berkas
        dapat di-parse.

        Instalasi diuji dari keadaan kosong: `createdb simpus_laprak_alt`, lalu ketiga skrip SQL
        dijalankan berurutan. Urutan itu wajib karena `03_peminjaman.sql` merujuk `buku(id)` dan
        `anggota(id)`; menjalankannya lebih dulu akan gagal dengan
        `relation "buku" does not exist`. Setelah ketiga skrip berjalan, registrasi akun petugas,
        login, dan dashboard berjalan tanpa satu pun perubahan kode.

        `DB_SSLMODE` juga diuji pada dua arah. Tanpa variable itu, server lokal menolak koneksi dan
        halaman mengembalikan HTTP 500 dengan pesan generik sementara detailnya masuk ke log. Dengan
        `DB_SSLMODE=disable`, seluruh halaman berjalan normal.
      ]
    ),
    (
      subbab: "Ringkasan Pekerjaan",
      konten: [
        Jobsheet 13 memindahkan kredensial database ke `includes/config.php` yang membaca enam
        environment variable (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS`, `DB_SSLMODE`)
        dengan default lokal, lalu menulis ulang `includes/koneksi.php` agar menyusun DSN dari
        konfigurasi itu. Pesan kegagalan koneksi tidak lagi dicetak ke halaman.

        Override dibuktikan dengan database kedua `simpus_laprak_alt`: aplikasi yang sama dijalankan
        pada port 8001 dengan `DB_NAME=simpus_laprak_alt` dan menampilkan dashboard dari database
        kosong tanpa perubahan kode.

        Dokumentasi terdiri atas README dengan ERD empat tabel, matriks fitur tamu versus petugas,
        langkah instalasi, dan tabel environment variable; serta `docs/manual-pengguna.md` dengan
        sebelas tangkapan layar asli yang diambil dari aplikasi yang berjalan. Seluruh berkas PHP
        lolos `php -l` tanpa kesalahan sintaks.
      ]
    ),
  ))
]
