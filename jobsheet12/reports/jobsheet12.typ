#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent


#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 12 - INTEGRASI MODUL PEMINJAMAN",
  repository: "https://github.com/hafidzrafi/DnPWeb2026",
  footer_text: "Desain dan Pemrograman Web -- Jobsheet 12",
)[
  #tujuan(data: (
    [Menghubungkan tabel `buku` dan `anggota` melalui tabel `peminjaman` yang memuat dua foreign key.],
    [Menulis `sql/03_peminjaman.sql` dengan `SERIAL PRIMARY KEY`, `NOT NULL`, `DATE`, `VARCHAR`, dan `REFERENCES` tanpa `ON DELETE CASCADE`.],
    [Mencatat peminjaman di dalam database transaction sehingga pengurangan stok dan pencatatan transaksi berhasil atau gagal bersama.],
    [Mengunci baris buku dengan `SELECT ... FOR UPDATE` agar dua permintaan bersamaan tidak dapat membuat stok menjadi negatif.],
    [Mengimplementasikan pengembalian yang menambah stok kembali dan menolak pengembalian ganda.],
    [Menampilkan riwayat peminjaman per anggota dengan `JOIN` tiga tabel.],
    [Menyimpan seluruh source code pekerjaan pada repositori GitHub resmi: #link("https://github.com/hafidzrafi/DnPWeb2026")[https://github.com/hafidzrafi/DnPWeb2026].],
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Skema Relasi dan Tabel Peminjaman",
      deskripsi: [
        Tabel `peminjaman` menyimpan fakta bahwa seorang anggota meminjam satu buku pada tanggal tertentu. Karena fakta itu merujuk dua entitas lain, tabel ini tidak menyimpan nama anggota atau judul buku, melainkan kunci asing ke `anggota(id)` dan `buku(id)`. Menyimpan nama secara duplikat akan membuat data berbeda begitu nama anggota diubah di tabel asalnya.

        === Definisi Tabel

        ```sql
        CREATE TABLE IF NOT EXISTS peminjaman (
            id SERIAL PRIMARY KEY,
            buku_id INTEGER NOT NULL REFERENCES buku(id),
            anggota_id INTEGER NOT NULL REFERENCES anggota(id),
            tanggal_pinjam DATE NOT NULL DEFAULT CURRENT_DATE,
            tanggal_kembali DATE,
            status VARCHAR(20) NOT NULL DEFAULT 'dipinjam'
        );
        ```

        `SERIAL` membuat PostgreSQL memiliki tipe `INTEGER` yang nilainya diisi otomatis dari sequence, sehingga tidak perlu menghitung `MAX(id) + 1` sendiri. `NOT NULL` pada kedua foreign key membuat baris tanpa rujukan ditolak database: transaksi peminjaman yang tidak menyebut buku atau anggota tidak punya arti.

        `tanggal_kembali` sengaja tidak diberi `NOT NULL` karena saat baris dibuat buku belum dikembalikan. Kolom ini tetap `NULL` selama `status` bernilai `'dipinjam'`, dan baru diisi `CURRENT_DATE` ketika pengembalian diproses. `DEFAULT CURRENT_DATE` pada `tanggal_pinjam` membuat tanggal terisi otomatis bila pemanggil tidak menyebutkannya.

        === Tanpa `ON DELETE CASCADE`

        Versi tabel yang dipakai pada pekerjaan UTS menulis `REFERENCES buku(id) ON DELETE CASCADE`. Klausa itu berarti menghapus satu baris di `buku` ikut menghapus seluruh baris `peminjaman` yang merujuknya. Untuk tabel riwayat, perilaku tersebut salah: riwayat peminjaman adalah catatan kejadian yang sudah terjadi, bukan pelengkap data buku.

        Tanpa `CASCADE`, PostgreSQL berperilaku `NO ACTION`: `DELETE FROM buku WHERE id = 1` ditolak selama masih ada baris `peminjaman` yang merujuknya. Penghapusan data induk jadi keputusan sadar, bukan efek samping. Database uji yang masih memakai constraint lama diperbaiki tanpa menghapus data:

        ```sql
        ALTER TABLE peminjaman DROP CONSTRAINT peminjaman_buku_id_fkey;
        ALTER TABLE peminjaman ADD CONSTRAINT peminjaman_buku_id_fkey
            FOREIGN KEY (buku_id) REFERENCES buku(id);
        ```

        === Indeks Bawaan

        `PRIMARY KEY` membuat indeks pada `id`. PostgreSQL tidak otomatis membuat indeks pada kolom foreign key, sehingga pencarian "peminjaman milik anggota 2" membaca seluruh tabel. Pada data praktikum jumlahnya kecil, jadi indeks tambahan belum diperlukan; kebutuhan itu dicatat, bukan dikerjakan lebih dulu.

        === Guard Login pada Folder Baru

        Folder `peminjaman/` adalah folder tingkat dua, sama seperti `books/` dan `members/`. `includes/auth.php` menghitung path relatif menuju halaman login berdasarkan nama folder, sehingga daftar folder harus memuat nama baru itu. Tanpa perubahan tersebut, pengunjung yang belum login diarahkan ke `./auth/login.php` dari dalam folder `peminjaman/`, yaitu path yang tidak ada.

        ```php
        $root = in_array($current_folder, ['books', 'members', 'peminjaman'], true) ? '..' : '.';
        ```

        `includes/header.php` memakai pola yang sama untuk menghitung `$root_path` pada tautan navbar, dengan tambahan `'auth'` karena halaman login dan register juga memuat header.
      ],
      langkah: (
        [Menulis `sql/03_peminjaman.sql` sesuai spesifikasi jobsheet, tanpa `ON DELETE CASCADE`.],
        [Menjalankan `psql -d simpus_mini -f sql/03_peminjaman.sql` dan memeriksa hasilnya dengan `\d peminjaman`.],
        [Membandingkan constraint pada database uji dengan file SQL, lalu mengganti constraint `CASCADE` memakai `ALTER TABLE` agar data lama tidak hilang.],
        [Menambahkan `'peminjaman'` ke daftar folder pada `includes/auth.php` dan `includes/header.php`.],
      ),
      pertanyaan: (
        (
          [Mengapa tabel `peminjaman` menyimpan `buku_id` dan `anggota_id`, bukan `judul` dan `nama`?],
          [Karena keduanya adalah kunci asing: nilai yang disimpan hanya penunjuk ke baris asal, sehingga perubahan judul atau nama cukup dilakukan di satu tempat dan seluruh riwayat otomatis ikut benar. Menyalin teksnya akan membuat riwayat menampilkan data lama yang tidak lagi cocok dengan tabel induk.]
        ),
        (
          [Apa akibatnya bila `tanggal_kembali` diberi `NOT NULL`?],
          [Baris peminjaman tidak bisa dibuat sebelum buku dikembalikan, sebab saat itu tanggalnya belum diketahui. Nilai pengganti seperti `'0000-00-00'` atau tanggal pinjam itu sendiri akan mengaburkan perbedaan antara "belum kembali" dan "kembali pada hari yang sama".]
        ),
        (
          [Mengapa `ON DELETE CASCADE` tidak dipakai di sini padahal praktis?],
          [Karena `CASCADE` membuat satu perintah hapus menghilangkan riwayat yang tidak ada hubungannya dengan maksud pengguna. Pada tabel riwayat, menolak penghapusan (`NO ACTION`) memaksa operator memutuskan lebih dulu apa yang harus terjadi pada transaksi lamanya.]
        ),
      ),
    ),

    (
      subbab: "Percobaan 2: Pencatatan Peminjaman dengan Transaction",
      deskripsi: [
        Pencatatan peminjaman mengubah dua tabel sekaligus: satu baris baru di `peminjaman` dan pengurangan `stok` pada `buku`. Bila keduanya dijalankan sebagai perintah terpisah, kegagalan di tengah jalan meninggalkan data yang tidak konsisten, misalnya transaksi tercatat tetapi stok tidak berkurang.

        === Form Peminjaman

        Dropdown buku hanya memuat buku yang stoknya tersedia, sehingga pilihan yang pasti gagal tidak ditawarkan sejak awal. Ini kenyamanan tampilan, bukan pengamanan: nilai `buku_id` tetap berasal dari klien dan diverifikasi ulang di sisi server.

        ```php
        $daftar_buku = $pdo->query(
            "SELECT id, judul, stok FROM buku WHERE stok > 0 ORDER BY judul ASC"
        )->fetchAll();
        ```

        #align(center)[#block(breakable: false)[
          #image("ss01_form_peminjaman.png", width: 85%)
          *Gambar 2.1:* Form Peminjaman Baru dengan Anggota dan Buku yang Dipilih.
        ]]

        Sebelum transaksi dicatat, stok "Pemrograman Web Modern" bernilai 3.

        #align(center)[#block(breakable: false)[
          #image("ss02_stok_sebelum.png", width: 85%)
          *Gambar 2.2:* Stok Buku Sebelum Peminjaman Dicatat.
        ]]

        === Transaction dan Penguncian Baris

        ```php
        $pdo->beginTransaction();

        $stmt_buku = $pdo->prepare("SELECT judul, stok FROM buku WHERE id = :id FOR UPDATE");
        $stmt_buku->execute([':id' => $buku_id]);
        $buku = $stmt_buku->fetch();

        if (!$buku || (int) $buku['stok'] < 1) {
            throw new Exception('Stok buku tidak tersedia.');
        }

        $insert = $pdo->prepare(
            "INSERT INTO peminjaman (buku_id, anggota_id, tanggal_pinjam, status)
             VALUES (:buku_id, :anggota_id, :tanggal_pinjam, 'dipinjam')"
        );
        $insert->execute([...]);

        $update_stok = $pdo->prepare("UPDATE buku SET stok = stok - 1 WHERE id = :id");
        $update_stok->execute([':id' => $buku_id]);

        $pdo->commit();
        ```

        `beginTransaction()` menunda penyimpanan sampai `commit()`. Bila salah satu perintah melempar exception, blok `catch` memanggil `rollBack()` dan kedua perubahan dibatalkan bersama.

        `FOR UPDATE` menambah kunci baris pada hasil `SELECT`. Selama transaksi pertama belum selesai, transaksi kedua yang membaca baris buku yang sama akan menunggu, lalu melihat stok yang sudah diperbarui. Tanpa kunci itu, dua transaksi dapat sama-sama membaca `stok = 1`, sama-sama menilai stok cukup, dan sama-sama mengurangi, sehingga stok berakhir `-1`.

        Pengujian dilakukan dengan satu buku berstok 1 dan dua permintaan peminjaman yang dikirim bersamaan untuk anggota berbeda. Hasilnya satu baris `peminjaman` terbentuk, satu permintaan ditolak dengan pesan "Stok buku tidak tersedia.", dan stok berakhir 0, bukan negatif.

        === Hasil Setelah Transaksi

        Stok "Pemrograman Web Modern" turun dari 3 menjadi 2.

        #align(center)[#block(breakable: false)[
          #image("ss03_stok_sesudah.png", width: 85%)
          *Gambar 2.3:* Stok Buku Berkurang Satu Setelah Peminjaman Berhasil.
        ]]

        Kartu "Sedang Dipinjam" pada dashboard tidak lagi bernilai statis. Angkanya dihitung dari tabel `peminjaman`, sehingga bertambah tanpa ada kode yang memperbaruinya secara manual.

        ```php
        $sedang_dipinjam = (int) $pdo->query(
            "SELECT COUNT(*) FROM peminjaman WHERE status = 'dipinjam'"
        )->fetchColumn();
        ```

        #align(center)[#block(breakable: false)[
          #image("ss04_dashboard_sedang_dipinjam.png", width: 85%)
          *Gambar 2.4:* Kartu "Sedang Dipinjam" Menampilkan 1 Transaksi Aktif.
        ]]

        === Pesan Error yang Aman

        Blok `catch` memisahkan `PDOException` dari exception lain. Pesan database hanya masuk ke `error_log()`, sedangkan pengguna menerima pesan generik, karena pesan `PDOException` memuat nama tabel dan constraint yang tidak perlu diketahui pengunjung. Pesan validasi yang ditulis sendiri, seperti "Stok buku tidak tersedia.", justru aman ditampilkan karena memang ditujukan untuk pengguna.

        ```php
        } catch (PDOException $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            error_log('SIMPUS-Mini: ' . $e->getMessage());
            $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal mencatat transaksi karena kesalahan database.'];
        }
        ```
      ],
      langkah: (
        [Menambahkan `csrf_field()` pada form peminjaman dan `csrf_verify()` pada pemrosesnya.],
        [Membungkus `INSERT` ke `peminjaman` dan `UPDATE` stok di dalam `beginTransaction()` dan `commit()`.],
        [Menambahkan `SELECT ... FOR UPDATE` sebelum pemeriksaan stok.],
        [Memvalidasi `tanggal_pinjam` dengan `DateTime::createFromFormat()` agar nilai selain format `Y-m-d` ditolak.],
        [Mengirim dua permintaan peminjaman bersamaan untuk satu buku berstok 1 dan memeriksa hasil akhir stok.],
        [Mengisi form peminjaman lewat browser, lalu memeriksa daftar buku dan kartu dashboard.],
      ),
      pertanyaan: (
        (
          [Mengapa `rollBack()` hanya dipanggil bila `$pdo->inTransaction()` bernilai benar?],
          [Karena exception dapat terjadi setelah `commit()` berhasil, misalnya pada baris setelahnya. Memanggil `rollBack()` tanpa transaksi aktif akan melempar `PDOException` baru yang menutupi error asli dan membuat pesan yang dilihat pengguna menyesatkan.]
        ),
        (
          [Apa bedanya `stok = stok - 1` dengan membaca stok di PHP lalu menulis angka hasil pengurangan?],
          [`stok = stok - 1` menghitung di dalam database sebagai satu operasi atomik, sehingga nilainya selalu berasal dari keadaan terbaru. Membaca lalu menulis kembali membuka celah antara baca dan tulis yang dapat diisi transaksi lain, persis pola yang menyebabkan stok negatif.]
        ),
        (
          [Mengapa `FOR UPDATE` diletakkan sebelum pemeriksaan stok, bukan sesudahnya?],
          [Karena yang dikunci adalah baris yang dibaca. Bila pemeriksaan dilakukan lebih dulu tanpa kunci, dua transaksi dapat lolos pemeriksaan yang sama sebelum salah satunya sempat mengunci baris, dan keputusan "stok cukup" itu menjadi basi.]
        ),
        (
          [Mengapa dropdown yang hanya menampilkan stok tersedia tidak cukup sebagai pengamanan?],
          [Isi dropdown berasal dari HTML yang dikirim ke browser dan dapat diubah atau dilewati dengan mengirim POST langsung. Pemeriksaan di server tetap wajib karena klien tidak pernah dipercaya.]
        ),
      ),
    ),

    (
      subbab: "Percobaan 3: Pengembalian Buku",
      deskripsi: [
        Pengembalian adalah kebalikan dari peminjaman: status transaksi berubah menjadi `'dikembalikan'`, `tanggal_kembali` diisi, dan stok buku bertambah satu. Ketiga perubahan itu tetap harus terjadi bersama.

        === Daftar Peminjaman Aktif

        Halaman `peminjaman/kembali.php` menampilkan baris dengan `status = 'dipinjam'` beserta tombol Kembalikan pada setiap baris. Tombol itu membungkus `id` transaksi dalam hidden input dan meminta konfirmasi sebelum mengirim.

        #align(center)[#block(breakable: false)[
          #image("ss05_halaman_pengembalian.png", width: 85%)
          *Gambar 3.1:* Daftar Peminjaman Aktif Sebelum Pengembalian Diproses.
        ]]

        === Transaction Kebalikan

        ```php
        $pdo->beginTransaction();

        $stmt = $pdo->prepare("SELECT buku_id, status FROM peminjaman WHERE id = :id FOR UPDATE");
        $stmt->execute([':id' => $id]);
        $trx = $stmt->fetch();

        if (!$trx || $trx['status'] !== 'dipinjam') {
            throw new Exception('Transaksi tidak ditemukan atau buku sudah dikembalikan sebelumnya.');
        }

        $update_trx = $pdo->prepare(
            "UPDATE peminjaman SET status = 'dikembalikan', tanggal_kembali = CURRENT_DATE WHERE id = :id"
        );
        $update_trx->execute([':id' => $id]);

        $update_stok = $pdo->prepare("UPDATE buku SET stok = stok + 1 WHERE id = :buku_id");
        $update_stok->execute([':buku_id' => $trx['buku_id']]);

        $pdo->commit();
        ```

        Pemeriksaan `status !== 'dipinjam'` menutup pengembalian ganda. Tanpa pemeriksaan itu, menekan tombol dua kali atau mengirim ulang POST yang sama akan menambah stok dua kali untuk satu buku yang hanya keluar sekali. `FOR UPDATE` di sini berfungsi sama seperti pada peminjaman: dua permintaan pengembalian untuk transaksi yang sama diproses berurutan, dan yang kedua melihat status yang sudah berubah.

        === Hasil

        Stok kembali bertambah satu dan daftar peminjaman aktif menjadi kosong.

        #align(center)[#block(breakable: false)[
          #image("ss06_stok_kembali.png", width: 85%)
          *Gambar 3.2:* Pesan Berhasil dan Daftar Peminjaman Aktif yang Sudah Kosong.
        ]]

        Pengujian tambahan: POST kedua untuk `id` yang sama ditolak dengan pesan "Transaksi tidak ditemukan atau buku sudah dikembalikan sebelumnya.", dan POST tanpa token CSRF menghasilkan HTTP 403 tanpa menyentuh database.
      ],
      langkah: (
        [Menambahkan `csrf_field()` pada setiap form pengembalian dan `csrf_verify()` pada `proses_kembali.php`.],
        [Menambahkan `SELECT ... FOR UPDATE` dan pemeriksaan `status` sebelum memperbarui baris.],
        [Memproses pengembalian lewat browser dan memeriksa stok serta daftar transaksi aktif.],
        [Mengirim POST pengembalian kedua untuk transaksi yang sama dan memastikan permintaan ditolak.],
        [Mengirim POST tanpa token CSRF dan memastikan respons 403.],
      ),
      pertanyaan: (
        (
          [Mengapa `tanggal_kembali` diisi `CURRENT_DATE` dan bukan tanggal yang dikirim pengguna?],
          [Tanggal kembali adalah catatan kejadian yang dipakai untuk menghitung keterlambatan. Bila nilainya berasal dari input, pengguna dapat memundurkannya agar pinjaman terlihat tidak terlambat. Tanggal pinjam tetap dapat diisi karena pencatatan administratif kadang dilakukan setelah kejadian, sedangkan tanggal kembali selalu "sekarang".]
        ),
        (
          [Mengapa pengembalian ganda berbahaya meski hanya menambah stok?],
          [Karena stok menjadi lebih besar dari jumlah buku fisik. Setelah itu dua orang dapat meminjam buku yang sebenarnya hanya tersisa satu, dan data stok tidak lagi dapat dipakai sebagai dasar keputusan.]
        ),
        (
          [Mengapa pengembalian tetap memakai transaction padahal hanya dua perintah?],
          [Karena dua perintah itu mengubah dua tabel. Bila `UPDATE peminjaman` berhasil tetapi `UPDATE buku` gagal, transaksi tercatat selesai sementara stok tidak bertambah, dan tidak ada cara mengetahui selisihnya tanpa memeriksa data secara manual.]
        ),
      ),
    ),

    (
      subbab: "Percobaan 4: Riwayat Peminjaman dengan JOIN",
      deskripsi: [
        Tabel `peminjaman` hanya menyimpan kunci asing, sehingga halaman riwayat tidak dapat menampilkan nama anggota atau judul buku tanpa membaca tabel lain. `JOIN` menggabungkan baris dari beberapa tabel berdasarkan nilai yang sama pada kolom penghubung.

        ```sql
        SELECT p.id, a.nama, a.no_anggota, b.judul,
               p.tanggal_pinjam, p.tanggal_kembali, p.status
        FROM peminjaman p
        JOIN anggota a ON a.id = p.anggota_id
        JOIN buku b ON b.id = p.buku_id
        ORDER BY p.tanggal_pinjam DESC, p.id DESC
        ```

        `JOIN` di sini adalah `INNER JOIN`: hanya baris `peminjaman` yang kedua rujukannya ditemukan yang muncul. Karena kedua foreign key bersifat `NOT NULL` dan dijamin `REFERENCES`, setiap baris pasti punya pasangan, sehingga tidak ada data yang hilang diam-diam.

        Halaman juga menyediakan filter per anggota. Nilai filter tidak disisipkan ke string SQL, melainkan diikat sebagai parameter:

        ```php
        $sql = "... FROM peminjaman p JOIN anggota a ON a.id = p.anggota_id
                JOIN buku b ON b.id = p.buku_id";
        $params = [];
        if ($anggota_id !== '') {
            $sql .= " WHERE p.anggota_id = :anggota_id";
            $params[':anggota_id'] = $anggota_id;
        }
        ```

        #align(center)[#block(breakable: false)[
          #image("ss07_riwayat_selesai.png", width: 85%)
          *Gambar 4.1:* Riwayat Transaksi Menampilkan Anggota, Buku, dan Kedua Tanggal.
        ]]

        Satu baris menampilkan transaksi yang baru selesai: anggota Siti Aminah, buku "Pemrograman Web Modern", tanggal pinjam dan tanggal kembali sama karena pengembalian diproses pada hari yang sama, serta status "Dikembalikan".

        === Guard Tetap Berlaku pada Modul Baru

        Setelah logout, halaman modul peminjaman tidak dapat dibuka lagi dan pengunjung dikembalikan ke form login.

        #align(center)[#block(breakable: false)[
          #image("ss08_redirect_setelah_logout.png", width: 85%)
          *Gambar 4.2:* Setelah Logout, Akses ke Modul Peminjaman Dialihkan ke Halaman Login.
        ]]
      ],
      langkah: (
        [Menulis query riwayat dengan dua `JOIN` dan `ORDER BY` pada tanggal pinjam terbaru.],
        [Menambahkan filter anggota yang menyisipkan klausa `WHERE` beserta parameternya secara terpisah.],
        [Membuka halaman riwayat dan memeriksa baris hasil transaksi yang baru selesai.],
        [Logout lalu membuka kembali halaman modul peminjaman untuk memastikan guard berjalan.],
      ),
      pertanyaan: (
        (
          [Mengapa `ORDER BY` memakai dua kolom, bukan hanya `tanggal_pinjam`?],
          [Karena beberapa transaksi dapat terjadi pada tanggal yang sama. Tanpa kolom kedua sebagai penentu, urutan baris di antara tanggal yang sama tidak dijamin konsisten antar pemanggilan. `id` menurun membuat transaksi terbaru selalu tampil lebih dulu.]
        ),
        (
          [Apa yang terjadi bila klausa `WHERE` disusun dengan menggabungkan nilai filter langsung ke string SQL?],
          [Nilai dari klien menjadi bagian struktur query, sehingga isian seperti `1 OR 1=1` mengubah arti perintah dan `1; DROP TABLE` berpotensi dieksekusi. Menyimpan klausa dan parameternya terpisah membuat nilai selalu diperlakukan sebagai data.]
        ),
        (
          [Mengapa nama tabel diberi alias `p`, `a`, dan `b`?],
          [Karena `id` dan `status` ada di lebih dari satu tabel. Alias membuat setiap kolom dapat ditunjuk tanpa ambigu, dan query tetap terbaca ketika jumlah tabel yang digabung bertambah.]
        ),
      ),
    ),
  ))

  #tugas(data: (
    (
      subbab: "Validasi Batas 14 Hari Pinjaman",
      konten: [
        Spesifikasi jobsheet meminta anggota yang masih menahan buku lebih dari 14 hari tidak boleh meminjam lagi. Aturan ini diterapkan sebelum transaksi dibuka, sebagai satu query hitung di dalam transaksi yang sama:

        ```php
        $cek_terlambat = $pdo->prepare(
            "SELECT COUNT(*) FROM peminjaman
             WHERE anggota_id = :anggota_id
               AND status = 'dipinjam'
               AND tanggal_pinjam < CURRENT_DATE - INTERVAL '14 days'"
        );
        $cek_terlambat->execute([':anggota_id' => $anggota_id]);
        if ((int) $cek_terlambat->fetchColumn() > 0) {
            throw new Exception('Anggota masih memiliki pinjaman aktif lebih dari 14 hari.');
        }
        ```

        Tiga kondisi digabung dengan `AND` agar yang dihitung hanya pinjaman yang benar-benar terlambat: milik anggota tersebut, masih berstatus `'dipinjam'`, dan tanggal pinjamnya lebih lama dari 14 hari lalu. Buku yang sudah dikembalikan tidak lagi menghalangi, sekalipun dulu sempat terlambat.

        `INTERVAL '14 days'` dihitung oleh PostgreSQL, bukan oleh PHP. Selisih tanggal jadi memakai zona waktu dan tipe `DATE` milik database, sehingga tidak terpengaruh perbedaan jam server aplikasi.

        Pengujian memakai anggota dengan pinjaman aktif sejak 12 Oktober 2026, yaitu 35 hari sebelum pengujian. Permintaan peminjaman baru ditolak dengan pesan "Anggota masih memiliki pinjaman aktif lebih dari 14 hari.", dan stok buku tidak berubah.

        Batas 14 hari ditulis langsung di query, bukan diambil dari tabel pengaturan. Untuk satu aturan yang tidak pernah berubah selama praktikum, memindahkannya ke konfigurasi hanya menambah satu tempat yang dapat salah tanpa ada yang meminta. Bila nanti batas itu berbeda per jenis anggota, barulah nilainya perlu disimpan di database.
      ]
    ),
    (
      subbab: "Ringkasan Pekerjaan",
      konten: [
        Jobsheet 12 menambahkan modul peminjaman yang menghubungkan `buku` dan `anggota` lewat tabel `peminjaman` dengan dua foreign key tanpa `ON DELETE CASCADE`. Modul terdiri atas lima berkas di `peminjaman/` (`tambah`, `proses_tambah`, `kembali`, `proses_kembali`, `riwayat`), satu berkas SQL, dan perubahan pada `includes/auth.php`, `includes/header.php`, serta `index.php`.

        Seluruh operasi yang mengubah dua tabel dijalankan di dalam transaction, dan setiap pembacaan stok yang menentukan keputusan memakai `SELECT ... FOR UPDATE`. Kedua pemroses memverifikasi token CSRF sebelum menyentuh database, dan seluruh output teks dibungkus `e()`.

        Enam pengujian dijalankan dan hasilnya tercatat di `README.md`: stok turun satu setelah peminjaman, kartu dashboard mengikuti jumlah transaksi aktif, pengembalian mengembalikan stok, pengembalian ganda ditolak, POST tanpa token CSRF menghasilkan HTTP 403, pinjaman terlambat memblokir peminjaman baru, dan dua permintaan bersamaan pada stok 1 hanya menghasilkan satu transaksi. Seluruh berkas PHP lolos `php -l` tanpa kesalahan sintaks.
      ]
    ),
  ))
]
