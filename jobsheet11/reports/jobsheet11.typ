#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 11 - KEAMANAN WEB DASAR",
  repository: "https://github.com/hafidzrafi/DnPWeb2026",
  footer_text: "Desain dan Pemrograman Web -- Jobsheet 11",
)[
  #tujuan(data: (
    "Memahami lima kerentanan web dasar yang diaudit pada aplikasi SIMPUS-Mini: SQL Injection, XSS, CSRF, validasi input, dan session fixation.",
    [Menerapkan escaping output melalui fungsi pembantu `e()` berbasis `htmlspecialchars()` dengan `ENT_QUOTES` dan encoding UTF-8.],
    [Mengimplementasikan proteksi CSRF berbasis token per sesi dengan `random_bytes()`, `csrf_field()`, dan verifikasi `hash_equals()`.],
    [Menutup celah session fixation melalui `session_regenerate_id(true)` pada momen transisi status autentikasi.],
    [Membuktikan setiap perbaikan dengan pengujian konkret, bukan sekadar klaim, dan mendokumentasikannya dalam `docs/security-checklist.md`.],
    [Menyimpan seluruh source code pekerjaan pada repositori GitHub resmi: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Escaping Output dan Uji XSS",
      deskripsi: [
        XSS terjadi ketika data yang berasal dari pengguna dicetak kembali ke HTML tanpa di-escape, sehingga browser memperlakukannya sebagai markup dan menjalankan skrip di dalamnya. Perbaikan dilakukan dengan memusatkan seluruh escaping pada satu fungsi, lalu mengganti setiap pemanggilan `htmlspecialchars()` yang tersebar dengan fungsi tersebut.

        === Fungsi Pembantu `e()`
        Berkas baru `includes/helpers.php` memuat satu fungsi yang dipakai seluruh halaman. Parameter `ENT_QUOTES` meng-escape tanda kutip tunggal dan ganda sekaligus, sehingga nilai aman dipakai baik sebagai isi elemen maupun sebagai nilai atribut.

        ```php
        <?php
        function e($value): string
        {
            return htmlspecialchars((string) ($value ?? ''), ENT_QUOTES, 'UTF-8');
        }
        ```

        Fungsi ini di-`require_once` dari `includes/header.php`, sehingga setiap halaman yang memuat header otomatis memilikinya.

        === Penerapan pada Output Data
        Seluruh kolom teks yang berasal dari database dibungkus `e()`, termasuk `judul`, `pengarang`, `isbn`, `kategori`, `nama`, `alamat`, dan `no_hp`. Nama petugas pada navbar juga dibungkus karena nilainya berasal dari input form registrasi.

        ```php
        <td><?= e($buku['judul'] ?? '') ?></td>
        <span class="user-greeting">Halo, <?= e($_SESSION['user']['username'] ?? 'User') ?></span>
        ```

        Atribut `value` pada form Edit memakai pola yang sama, karena tanda kutip yang tidak di-escape dapat menutup atribut lebih awal dan menyisipkan atribut baru.

        ```php
        <input type="text" id="judul" name="judul" required value="<?= e($buku['judul']) ?>">
        ```

        Kolom `tahun` dan `stok` tetap dicetak tanpa `e()` karena bertipe INTEGER di PostgreSQL: nilai bertanda `<` ditolak oleh tipe kolom, sehingga isinya tidak mungkin mengandung markup.

        === Bukti Pengujian
        Buku baru ditambahkan dengan judul persis `<script>alert(1)</script>`.

        #align(center)[
          #image("ss02_xss_form_judul_script.png", width: 85%)
          *Gambar 1.1:* Form Tambah Buku Diisi Muatan XSS `<script>alert(1)</script>`.
        ]

        Setelah disimpan, halaman Daftar Buku menampilkan muatan tersebut sebagai teks biasa. Tidak ada kotak dialog `alert()` yang muncul, dan baris buku tetap tersimpan utuh.

        #align(center)[
          #image("ss03_xss_daftar_buku_teks.png", width: 85%)
          *Gambar 1.2:* Daftar Buku Menampilkan Muatan XSS sebagai Teks, Bukan Mengeksekusinya.
        ]

        Pemeriksaan pada HTML mentah memastikan mekanismenya: karakter `<`, `>`, dan `"` berubah menjadi entity.

        ```text
        &lt;script&gt;alert(&quot;xss&quot;)&lt;/script&gt;
        ```
      ],
      langkah: (
        [Membuat berkas `includes/helpers.php` berisi fungsi `e()`.],
        [Menambahkan `require_once __DIR__ . '/helpers.php';` pada `includes/header.php`.],
        [Mengganti seluruh pemanggilan `htmlspecialchars(` pada output data dengan `e(`.],
        [Menjalankan `rg -n "htmlspecialchars\\(" --glob '*.php'` untuk memastikan tidak ada sisa pemanggilan di luar `helpers.php`.],
        [Menyimpan buku berjudul `<script>alert(1)</script>` melalui form Tambah Buku.],
        "Membuka Daftar Buku dan memastikan muatan tampil sebagai teks.",
      ),
      pertanyaan: (
        (
          [Mengapa `ENT_QUOTES` diperlukan padahal data sudah di-escape?],
          [Escaping default PHP versi lama hanya mengubah tanda kutip ganda. Pada form Edit, nilai dicetak di dalam atribut `value="..."` yang juga diapit tanda kutip ganda. Tanpa `ENT_QUOTES`, tanda kutip di dalam data dapat menutup atribut lebih awal dan menyisipkan atribut baru seperti `onmouseover="..."`.]
        ),
        (
          [Mengapa kolom `tahun` dan `stok` tidak perlu dibungkus `e()`?],
          [Keduanya bertipe INTEGER. PostgreSQL menolak menyimpan teks seperti `<script>` ke kolom angka, sehingga nilainya selalu berupa digit. Membungkusnya tidak salah, tetapi tidak menambah keamanan.]
        ),
      ),
    ),
    (
      subbab: "Percobaan 2: Proteksi CSRF dengan Token per Sesi",
      deskripsi: [
        Pembatasan metode POST tidak cukup mencegah CSRF: browser mengirim form dari situs mana pun beserta cookie sesi korban. Lapisan tambahan yang dibutuhkan adalah token rahasia yang hanya diketahui server dan halaman yang benar-benar dibuka dari aplikasi ini.

        === Membuat dan Menyisipkan Token
        Berkas baru `includes/csrf.php` memuat tiga fungsi. Token dibuat sekali per sesi dari 32 byte acak kriptografis, lalu diubah ke heksadesimal agar aman dipakai sebagai nilai atribut.

        ```php
        function csrf_token(): string
        {
            if (empty($_SESSION['csrf_token'])) {
                $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
            }
            return $_SESSION['csrf_token'];
        }

        function csrf_field(): string
        {
            return '<input type="hidden" name="csrf_token" value="' . csrf_token() . '">';
        }
        ```

        `csrf_field()` dipanggil di dalam delapan form POST: Tambah Buku, Edit Buku, Hapus Buku, Tambah Anggota, Edit Anggota, Hapus Anggota, Login, dan Register.

        ```php
        <form action="proses_tambah.php" method="POST">
            <?= csrf_field() ?>
            <div class="form-group">
        ```

        === Verifikasi Sebelum Menyentuh Database
        Setiap pemroses memanggil `csrf_verify()` sebelum query apa pun dijalankan. Perbandingan memakai `hash_equals()` agar waktu eksekusinya tidak bergantung pada tingkat kemiripan kedua string.

        ```php
        function csrf_verify(): void
        {
            $token = $_POST['csrf_token'] ?? '';
            if ($token === '' || !hash_equals($_SESSION['csrf_token'] ?? '', $token)) {
                http_response_code(403);
                die('Permintaan ditolak: token CSRF tidak valid atau kedaluwarsa.');
            }
        }
        ```

        `die()` penting: tanpa itu, kode `INSERT`/`UPDATE`/`DELETE` setelah pemeriksaan akan tetap berjalan meski token ditolak.

        === Bukti Pengujian
        Login dilakukan lewat curl dengan cookie jar, lalu POST dikirim tanpa menyertakan token.

        ```text
        $ curl -X POST http://127.0.0.1:8000/books/proses_tambah.php -d "judul=x"
        Permintaan ditolak: token CSRF tidak valid atau kedaluwarsa.
        csrf:403
        ```

        Sebagai pembanding, POST yang sama dengan token yang benar berhasil dan mengembalikan `insert:302` menuju `books/list.php`.
      ],
      langkah: (
        [Membuat berkas `includes/csrf.php` berisi `csrf_token()`, `csrf_field()`, dan `csrf_verify()`.],
        [Menambahkan `require_once __DIR__ . '/csrf.php';` pada `includes/header.php`.],
        [Menyisipkan `<?= csrf_field() ?>` tepat setelah tag `<form ... method="POST">` pada delapan form.],
        [Menambahkan `require_once __DIR__ . '/../includes/csrf.php';` dan `csrf_verify();` pada delapan pemroses.],
        "Menguji POST tanpa token setelah login dan memastikan respons HTTP 403.",
        "Menguji POST dengan token yang benar dan memastikan data tersimpan.",
      ),
      pertanyaan: (
        (
          [Mengapa perbandingan token memakai `hash_equals()` dan bukan operator `===`?],
          [`===` berhenti pada karakter pertama yang berbeda, sehingga waktu eksekusinya bergantung pada panjang awalan yang cocok. Perbedaan waktu itu, dalam kondisi tertentu, dapat dipakai menebak token karakter demi karakter. `hash_equals()` membandingkan seluruh string dalam waktu yang konstan.]
        ),
        (
          [Mengapa form pencarian dengan metode GET tidak diberi token?],
          [CSRF mengeksploitasi aksi yang mengubah state. Permintaan GET pada aplikasi ini hanya membaca data, sehingga permintaan lintas situs tidak mengubah apa pun. Menambahkan token pada GET justru merusak sifat URL yang dapat dibagikan.]
        ),
      ),
    ),
    (
      subbab: "Percobaan 3: Urutan Guard Autentikasi dan CSRF",
      deskripsi: [
        Urutan pemanggilan menentukan perilaku: guard autentikasi harus berjalan lebih dulu agar pengunjung tanpa sesi tidak pernah mencapai pemeriksaan token, dan langsung diarahkan ke halaman Login.

        ```php
        require_once __DIR__ . '/../includes/auth.php';
        require_once __DIR__ . '/../includes/csrf.php';
        require_once __DIR__ . '/../includes/koneksi.php';

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: list.php');
            exit;
        }

        csrf_verify();
        ```

        === Bukti Pengujian
        POST dikirim ke `books/proses_tambah.php` dari sesi yang belum login sama sekali.

        ```text
        $ curl -o /dev/null -w "%{http_code} -> %{redirect_url}\n" -X POST \
            http://127.0.0.1:8000/books/proses_tambah.php -d "judul=x"
        guard:302 -> http://127.0.0.1:8000/auth/login.php
        ```

        Status 302 menuju halaman Login, bukan 403. Artinya `auth.php` menghentikan eksekusi sebelum `csrf_verify()` sempat dipanggil.

        #align(center)[
          #image("ss05_guard_redirect_login.png", width: 85%)
          *Gambar 3.1:* Halaman Login Muncul Setelah Permintaan ke Halaman Terproteksi tanpa Sesi.
        ]

        #align(center)[
          #image("ss06_dashboard_setelah_login.png", width: 85%)
          *Gambar 3.2:* Dashboard Setelah Login Berhasil, dengan Nama Petugas pada Navbar.
        ]
      ],
      langkah: (
        [Memastikan `includes/auth.php` di-require paling awal pada setiap pemroses.],
        [Menempatkan `csrf_verify()` setelah pemeriksaan metode HTTP dan sebelum query.],
        "Mengirim POST tanpa sesi dan memastikan respons 302 menuju halaman Login.",
        "Mengirim POST dengan sesi aktif tetapi tanpa token dan memastikan respons 403.",
      ),
      pertanyaan: (
        (
          [Apa akibatnya bila `csrf_verify()` dipanggil sebelum `auth.php`?],
          [Pengunjung tanpa sesi akan menerima HTTP 403, bukan diarahkan ke halaman Login. Selain membingungkan pengguna, perilaku itu membocorkan bahwa endpoint tersebut ada dan sedang menunggu token.]
        ),
      ),
    ),
    (
      subbab: "Percobaan 4: Session Fixation dan Audit SQL Injection",
      deskripsi: [
        === Regenerasi Session ID
        Session fixation memanfaatkan ID sesi yang tidak berubah pada momen login. Penyerang yang sudah mengetahui ID sesi sebelum korban login dapat memakai ID yang sama setelah korban berhasil masuk. Perbaikannya satu baris, ditempatkan tepat setelah verifikasi password berhasil.

        ```php
        if ($user && password_verify($password, $user['password'])) {
            session_regenerate_id(true);

            $_SESSION['user'] = [
                'id' => $user['id'],
                'nama' => $user['nama'],
                'username' => $user['username'],
                'role' => $user['role'] ?? 'petugas',
            ];
        ```

        Argumen `true` menghapus berkas sesi lama di sisi server, sehingga ID yang mungkin sudah diketahui pihak lain tidak lagi valid.

        === Bukti Pengujian
        ID sesi dibaca dari cookie jar sebelum dan sesudah login.

        ```text
        before=a29d9bf54c994c3b4b26aa6d9a7428ac
        after =f61dd399d90034b2506c605b35cbfb50
        SESSION_ID_CHANGED=yes

        $ curl -o /dev/null -w "%{http_code}\n" -H "Cookie: PHPSESSID=a29d9bf5..." \
            http://127.0.0.1:8000/index.php
        302
        ```

        ID lama tidak dapat dipakai mengakses dashboard, membuktikan sesi lama benar-benar dibuang.

        === Audit SQL Injection
        Seluruh query di `books/`, `members/`, dan `auth/` sudah memakai prepared statement sejak Jobsheet 8. Audit ulang memastikan tidak ada query yang menyisipkan `$_POST` atau `$_GET` ke dalam string SQL. Pengujian dilakukan dengan mengirim username `' OR '1'='1` pada form Login.

        #align(center)[
          #image("ss04_login_sql_injection_gagal.png", width: 85%)
          *Gambar 4.1:* Login Ditolak Setelah Percobaan SQL Injection `' OR '1'='1`.
        ]

        Placeholder `:username` membuat isi variabel selalu diperlakukan sebagai satu nilai teks yang dicari persis di kolom `username`, bukan sebagai bagian struktur query. Hasilnya tetap "Username atau password salah."

        === Penyembunyian Detail Error Internal
        Audit menemukan satu masalah tambahan di luar lima kerentanan wajib: pesan `PDOException::getMessage()` dicetak ke halaman, membocorkan nama tabel, kolom, dan detail koneksi. Pesan asli dipindahkan ke `error_log()`, sedangkan pengguna menerima pesan generik.

        ```php
        } catch (PDOException $e) {
            error_log('SIMPUS-Mini: ' . $e->getMessage());
            $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal menyimpan buku.'];
        }
        ```
      ],
      langkah: (
        [Menambahkan `session_regenerate_id(true)` tepat setelah `password_verify()` berhasil pada `auth/proses_login.php`.],
        "Membaca cookie jar sebelum dan sesudah login untuk membandingkan ID sesi.",
        "Memakai ulang ID sesi lama pada dashboard dan memastikan respons 302.",
        [Mengaudit seluruh query dengan `rg -n "query\\(|prepare\\(" --glob '*.php'`.],
        [Menguji login dengan username `' OR '1'='1` dan password sembarang.],
        [Mengganti seluruh pesan `getMessage()` yang tampil ke pengguna dengan pesan generik dan mencatat aslinya ke `error_log()`.],
      ),
      pertanyaan: (
        (
          [Mengapa `session_regenerate_id(true)` tidak dipanggil di `proses_register.php`?],
          [Registrasi tidak membuat pengguna langsung login; setelah mendaftar, pengguna diarahkan ke halaman Login. Tidak ada transisi status autentikasi yang perlu diamankan di titik itu.]
        ),
        (
          [Mengapa `session_regenerate_id(true)` tidak dipanggil di `logout.php`?],
          [`logout.php` memanggil `session_destroy()` yang menghapus seluruh data sesi. Sesi itu sudah berakhir, sehingga tidak ada identitas yang perlu diganti.]
        ),
        (
          [Mengapa pesan error database tidak boleh ditampilkan ke pengguna?],
          [Pesan `PDOException` memuat nama tabel, kolom, dan kadang detail koneksi. Informasi itu memudahkan penyerang memetakan struktur basis data sebelum menyusun serangan berikutnya. Pengguna hanya perlu tahu operasinya gagal, sedangkan pengembang memerlukan detailnya di log.]
        ),
      ),
    ),
  ))

  #tugas(data: (
    (
      subbab: "Ringkasan Audit Keamanan",
      konten: [
        Audit di Jobsheet 11 mencakup enam baris, seluruhnya didokumentasikan di `docs/security-checklist.md` beserta kondisi sebelum, perbaikan, dan bukti pengujiannya.

        *SQL Injection* sudah aman sejak Jobsheet 8 karena seluruh query ditulis dengan prepared statement PDO. Audit ulang memastikan tidak ada satu pun query yang menyisipkan `$_POST` atau `$_GET` langsung ke string SQL. Pengujian dengan `' OR '1'='1` pada form Login tetap ditolak.

        *XSS* diperbaiki dengan memusatkan escaping pada fungsi `e()` di `includes/helpers.php`. Seluruh kolom teks yang berasal dari database kini dibungkus fungsi itu, termasuk nama petugas pada navbar. Pengujian menyimpan `<script>alert(1)</script>` sebagai judul buku dan hasilnya tampil sebagai teks.

        *CSRF* ditutup dengan token per sesi dari `random_bytes(32)`, disisipkan ke delapan form POST, dan diverifikasi dengan `hash_equals()` sebelum query dijalankan. POST tanpa token menghasilkan HTTP 403 dan tidak pernah mencapai database.

        *Validasi dan sanitasi input* sudah ada sejak Jobsheet 7 sampai 9 berupa `is_numeric()` dan pemeriksaan wajib-isi. Audit mempertahankannya dan menambahkan cast `(int)` eksplisit pada `id` di hidden input form Edit agar nilai non-numerik tidak pernah ikut terkirim.

        *Session fixation* ditutup dengan `session_regenerate_id(true)` tepat setelah `password_verify()` berhasil. Pengujian menunjukkan ID sesi berubah setelah login dan ID lama tidak lagi dapat mengakses dashboard.

        *Kebocoran detail internal* ditemukan saat audit dan tidak termasuk lima kerentanan wajib. Pesan `PDOException::getMessage()` sebelumnya dicetak ke halaman. Setelah perbaikan, pesan asli masuk ke `error_log()` dan pengguna menerima pesan generik.

        Keseluruhan pekerjaan menghasilkan dua berkas baru (`includes/helpers.php` dan `includes/csrf.php`), perubahan pada sepuluh berkas halaman dan pemroses, serta satu dokumen audit. Seluruh berkas lolos `php -l` tanpa kesalahan sintaks.
      ]
    ),
  ))
]
