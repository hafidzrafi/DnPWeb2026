#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 9 - OPERASI LENGKAP CRUD PADA POSTGRESQL",
  repository: "https://github.com/hafidzrafi/DnPWeb2026",
  footer_text: "Desain dan Pemrograman Web -- Jobsheet 9",
)[
  #tujuan(data: (
    "Memahami siklus hidup lengkap arsitektur CRUD (Create, Read, Update, Delete) pada aplikasi web berbasis PostgreSQL.",
    "Menguasai alur pembacaan data eksisting melalui parameter URL HTTP GET untuk mengisi form pra-terisi pada edit.php.",
    "Mengimplementasikan pembaruan rekaman data (UPDATE) menggunakan Prepared Statements berparameter pada proses_edit.php.",
    "Menerapkan penggunaan input tersembunyi (<input type=\"hidden\" name=\"id\">) untuk pengikatan kunci utama entitas.",
    "Membangun penanganan operasi penghapusan data (DELETE) berbasis metode aman HTTP POST untuk mencegah eksekusi tak sengaja oleh crawler.",
    "Menerapkan penanganan kasus batas (edge cases) seperti parameter ID kosong atau ID tidak terdaftar di database.",
    "Mengintegrasikan umpan balik status transaksi (flash messages) pada setiap operasi mutasi data persisten.",
    [Menyimpan dan mendokumentasikan seluruh source code pekerjaan pada repositori GitHub resmi: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Perancangan Antarmuka Tabel CRUD dan Aksi Baris",
      deskripsi: [
        Pada percobaan pertama, tabel daftar buku dan anggota pada Jobsheet 9 disempurnakan dengan menambahkan kolom Aksi yang memuat tombol interaktif Edit dan tombol Hapus berbasis formulir POST.

        === 1.1 Struktur Kolom Aksi pada Tabel
        Setiap baris data dilengkapi dengan tautan navigasi menuju halaman formulir edit serta form mini untuk aksi destruktif:

        ```html
        <a href="edit.php?id=<?= urlencode($buku['id']) ?>" class="btn btn-secondary">Edit</a>
        <form action="hapus.php" method="POST" style="display:inline;" onsubmit="return confirm('Yakin ingin menghapus buku ini?');">
            <input type="hidden" name="id" value="<?= htmlspecialchars($buku['id']) ?>">
            <button type="submit" class="btn btn-danger">Hapus</button>
        </form>
        ```

        #align(center)[
          #image("ss01_tabel_crud_buku.png", width: 85%)
          *Gambar 1.1:* Tampilan Tabel Daftar Buku Menampilkan Kolom Aksi dengan Tombol Edit dan Hapus Terpadu.
        ]
      ],
      langkah: (
        "Memodifikasi berkas `books/list.php` dan `members/list.php` dengan menambahkan kolom header `<th>Aksi</th>`.",
        "Menyematkan tautan `edit.php?id=...` yang menyertakan identifier primary key pada setiap baris.",
        "Menyematkan form mini dengan method POST untuk pemanggilan `hapus.php`.",
        "Menguji kemunculan tombol aksi pada peramban web.",
      ),
      pertanyaan: (
        (
          [Mengapa identifier primary key pada URL wajib dienkode menggunakan `urlencode()`?],
          [`urlencode()` memastikan karakter khusus atau spasi pada parameter URL diubah menjadi format representasi persen (*percent-encoded*) yang valid sesuai standar RFC 3986, mencegah terputusnya query string atau salah tafsir parameter oleh web server.]
        ),
      ),
    ),
    (
      subbab: "Percobaan 2: Pengambilan Data Eksisting dan Form Pra-Terisi (Edit)",
      deskripsi: [
        Percobaan kedua mengimplementasikan alur pembacaan data sebelum proses modifikasi dilakukan pada berkas `edit.php`.

        === 2.1 Pengambilan Rekaman dan Pengisian Formulir
        Skrip mengekstrak `$_GET['id']`, memvalidasi keberadaannya, lalu menjalankan query penelusuran `SELECT * FROM buku WHERE id = :id`. Data yang diperoleh kemudian disuntikkan ke dalam atribut `value` elemen input:

        ```php
        $id = $_GET['id'] ?? null;
        if (!$id) {
            header('Location: list.php');
            exit;
        }

        $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = :id");
        $stmt->execute([':id' => $id]);
        $buku = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$buku) {
            header('Location: list.php');
            exit;
        }
        ```

        #align(center)[
          #image("ss02_form_edit_buku.png", width: 85%)
          *Gambar 1.2:* Formulir Edit Buku dengan Nilai-Nilai Isian yang Terisi Otomatis Sesuai Data di Database.
        ]

        #align(center)[
          #image("ss04_form_edit_anggota.png", width: 85%)
          *Gambar 1.3:* Formulir Edit Anggota yang Menampilkan Data Eksisting Anggota Terpilih.
        ]
      ],
      langkah: (
        "Membuat berkas formulir `books/edit.php` dan `members/edit.php`.",
        "Mengekstrak parameter GET dan menjalankan query pencarian rekaman tunggal.",
        "Menyematkan input tersembunyi `<input type=\"hidden\" name=\"id\" value=\"...\">`.",
        "Menguji pengisian form otomatis dengan mengklik tombol Edit pada tabel.",
      ),
      pertanyaan: (
        (
          [Apa fungsi elemen input tersembunyi `<input type="hidden" name="id">` pada formulir edit?],
          [Elemen `<input type="hidden">` bertugas membawa nilai kunci utama (`id`) entitas yang sedang disunting saat formulir disubmit ke server via POST, tanpa menampilkannya sebagai kolom isian yang dapat diubah oleh pengguna pada antarmuka visual.]
        ),
      ),
    ),
    (
      subbab: "Percobaan 3: Eksekusi Update Data dan Penghapusan Destruktif",
      deskripsi: [
        Percobaan ketiga mengimplementasikan pemrosesan pembaruan data (`UPDATE`) pada `proses_edit.php` serta eksekusi penghapusan data (`DELETE`) pada `hapus.php`.

        === 3.1 Pembaruan Data dengan UPDATE Statement
        Skrip `proses_edit.php` memvalidasi input, lalu mengeksekusi perintah SQL pembaruan berparameter:

        ```php
        $stmt = $pdo->prepare(
            "UPDATE buku SET judul = :judul, pengarang = :pengarang, tahun = :tahun,
             isbn = :isbn, stok = :stok, kategori = :kategori WHERE id = :id"
        );
        $stmt->execute([
            ':judul' => $judul,
            ':pengarang' => $pengarang,
            ':tahun' => (int) $tahun,
            ':isbn' => $isbn,
            ':stok' => (int) $stok,
            ':kategori' => $kategori,
            ':id' => $id,
        ]);
        ```

        #align(center)[
          #image("ss03_flash_edit_sukses.png", width: 85%)
          *Gambar 1.4:* Notifikasi Sukses Pembaruan Data Muncul dan Nilai Stok Buku Berhasil Terbarukan Menjadi 10.
        ]

        === 3.2 Penghapusan Data Aman Berbasis HTTP POST
        Pada `hapus.php`, server memverifikasi bahwa metode request adalah POST untuk mencegah eksekusi tidak sengaja oleh bot perayap web (*web crawler*):

        ```php
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: list.php');
            exit;
        }

        $id = $_POST['id'] ?? null;
        if ($id) {
            $stmt = $pdo->prepare("DELETE FROM buku WHERE id = :id");
            $stmt->execute([':id' => $id]);
        }
        ```

        #align(center)[
          #image("ss05_konfirmasi_hapus_crud.png", width: 85%)
          *Gambar 1.5:* Baris Rekaman Buku Berhasil Dihapus Permanen dari Database Pasca-Konfirmasi Pengguna.
        ]
      ],
      langkah: (
        "Mengembangkan skrip `proses_edit.php` dengan query UPDATE berparameter.",
        "Mengembangkan skrip `hapus.php` dengan pembatasan metode HTTP POST dan query DELETE.",
        "Menguji perubahan nilai data dan memverifikasi pembaruan nilai di database dan antarmuka.",
        "Menguji penghapusan baris data dan memverifikasi lenyapnya rekaman dari basis data.",
      ),
      pertanyaan: (
        (
          [Mengapa operasi penghapusan data dilarang menggunakan metode HTTP GET?],
          [Metode GET bersifat aman dan idempoten menurut standar RFC. Penggunaan GET pada aksi destruktif membuka celah di mana perayap web (*web crawlers/search bots*) atau fitur *link prefetching* peramban dapat memicu penghapusan database secara tidak sengaja saat menelusuri tautan halaman.]
        ),
      ),
    ),
  ))

  #tugas(data: (
    (
      subbab: "Tugas Evaluasi & Analisis Konseptual Jobsheet 9",
      konten: [
        Berikut adalah evaluasi kritis dan analisis mendalam terhadap lima pertanyaan evaluasi konsep pada Jobsheet 9:

        #table(
          columns: (0.4fr, 2.8fr),
          stroke: 0.5pt + rgb("#cbd5e1"),
          inset: 8pt,
          fill: (col, row) => if row == 0 { rgb("#f1f5f9") } else { none },
          align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
          table.header([*No*], [*Pertanyaan dan Jawaban Konseptual*]),
          [1], [
            *Soal:* Jelaskan siklus hidup lengkap operasi CRUD (Create, Read, Update, Delete) dalam arsitektur aplikasi web berbasis basis data relasional! Bagaimana pemisahan peran antara file formulir dan file pemroses mendukung arsitektur yang bersih? \ \
            *Jawaban:* \
            Siklus hidup CRUD mengintegrasikan empat manipulasi entitas inti: \
            1. *Create*: Pengguna mengirim data via formulir POST `tambah.php` -> diproses oleh `proses_tambah.php` menggunakan query `INSERT INTO`. \
            2. *Read*: Halaman `list.php` mengeksekusi `SELECT * FROM ...` dan menyajikan baris ke tabel HTML. \
            3. *Update*: Pengguna membuka `edit.php?id=...` yang membaca data eksisting -> formulir tersaji -> perubahan dikirim via POST ke `proses_edit.php` yang menjalankan `UPDATE ... WHERE id = :id`. \
            4. *Delete*: Pengguna memicu aksi form POST pada `hapus.php` yang menjalankan `DELETE FROM ... WHERE id = :id`. \
            Pemisahan antara berkas antarmuka presentasi (`edit.php`, `list.php`) dan berkas pengendali mutasi (`proses_edit.php`, `hapus.php`) menegakkan prinsip *Separation of Concerns* (SoC), menghasilkan kode yang terisolasi, mudah dipelihara, dan terlindung dari kerentanan *form resubmission*.
          ],
          [2], [
            *Soal:* Bagaimana alur kerja operasi Update data berjalan pada `edit.php` dan `proses_edit.php`? Mengapa input tersembunyi `<input type="hidden" name="id">` wajib disertakan di dalam formulir? \ \
            *Jawaban:* \
            Alur operasi Update dimulai ketika pengguna mengakses `edit.php?id=X`. Server membaca parameter GET, menarik data dari PostgreSQL melalui `SELECT ... WHERE id = :id`, dan menyuntikkan nilai atribut ke formulir. Saat formulir disubmit ke `proses_edit.php`, server membutuhkan penanda eksplisit mengenai baris mana yang harus diperbarui. Input tersembunyi `<input type="hidden" name="id" value="...">` bertugas membawa nilai primary key tersebut di dalam payload `$_POST` tanpa menampilkannya sebagai elemen yang dapat disunting oleh pengguna, sehingga query `UPDATE` dapat mengarahkan klausa `WHERE id = :id` secara presisi.
          ],
          [3], [
            *Soal:* Mengapa operasi penghapusan data (`hapus.php`) sengaja dirancang hanya menerima metode HTTP POST dan dilarang keras menggunakan metode HTTP GET? \ \
            *Jawaban:* \
            Berdasarkan spesifikasi arsitektur HTTP, metode GET didefinisikan sebagai metode yang aman (*safe*) dan tidak boleh menimbulkan efek samping mutasi pada status server (*side-effects*). Jika penghapusan data menggunakan tautan GET (`hapus.php?id=1`), sistem rentan terhadap malapetaka data: robot perayap mesin pencari (seperti Googlebot), ekstensi peramban, atau fitur *link prefetching* otomatis pada peramban akan memicu eksekusi penghapusan rekaman secara masif tanpa disengaja. Menggunakan metode POST memastikan operasi penghapusan memerlukan itikad transaksi formulir yang eksplisit dari pengguna.
          ],
          [4], [
            *Soal:* Bagaimana aplikasi menangani kasus batas (edge case) saat pengguna mencoba mengakses `edit.php` tanpa parameter `id` atau dengan `id` yang tidak terdaftar di database? \ \
            *Jawaban:* \
            Aplikasi menerapkan penanganan berjenjang melalui *guard clauses*: \
            1. Pengecekan awal memeriksa `if (!isset($_GET['id']) || empty($_GET['id']))`. Jika parameter absen, eksekusi langsung dialihkan ke `list.php` dengan `header('Location: list.php'); exit;`. \
            2. Jika parameter ada, query `SELECT * FROM buku WHERE id = :id` dijalankan. Jika ID tidak eksis di tabel, pemanggilan method `fetch()` akan menghasilkan nilai boolean `false`. \
            3. Kondisi `if (!$buku)` menangkap nilai false tersebut dan segera membelokkan alur kembali ke `list.php`, mencegah timbulnya peringatan PHP atau error indeks tidak terdefinisi (*Undefined array key*).
          ],
          [5], [
            *Soal:* Jelaskan peran klausa `WHERE id = :id` pada perintah `UPDATE` dan `DELETE`! Apa bahaya katastropik yang terjadi jika klausa `WHERE` tidak sengaja terlewatkan? \ \
            *Jawaban:* \
            Klausa `WHERE id = :id` berfungsi sebagai filter pembatas cakupan mutasi agar perintah hanya diaplikasikan secara spesifik pada satu baris data yang ditargetkan. Jika klausa `WHERE` tidak sengaja terlewatkan: \
            - Pada perintah `UPDATE buku SET stok = 0;`: Seluruh baris data di tabel buku tanpa terkecuali akan dimutasi serentak nilainya menjadi 0. \
            - Pada perintah `DELETE FROM buku;`: Seluruh rekaman data di tabel akan dimusnahkan secara permanen (*accidental table wipeout*). \
            Kehilangan klausa `WHERE` merupakan malapetaka integritas basis data yang berakibat fatal pada kerusakan data operasional.
          ],
        )
      ],
    ),
  ))
]
