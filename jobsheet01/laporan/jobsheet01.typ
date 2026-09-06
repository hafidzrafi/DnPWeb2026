#import "/laprak/_template/main.typ": lab_report, praktikum, tugas, tujuan, indent

#lab_report(
  title: "LAPORAN PRAKTIKUM",
  course: "DESAIN DAN PEMROGRAMAN WEB",
  subtitle: "JOBSHEET 1 - HTML DASAR",
)[
  #tujuan(data: (
    "Memahami konsep dasar Internet dan teknologi web.",
    "Melakukan instalasi dan konfigurasi web server lokal.",
    "Membuat halaman web statis menggunakan elemen-elemen dasar HTML.",
  ))

  #praktikum(data: (
    (
      subbab: "Percobaan 1: Instalasi Web Server",
      deskripsi: [
        Pada praktikum ini, sebagai pengganti Laragon yang berjalan di Windows, digunakan *PHP Built-in Server* yang tersedia secara bawaan di macOS. Server dijalankan dengan perintah berikut dari direktori kerja:

        ```bash
        php -S localhost:8000
        ```

        Server kemudian dapat diakses melalui browser di alamat `localhost:8000`.
      ],
      langkah: (),
      pertanyaan: (
        (
          [Buka browser Anda, ketikkan localhost kemudian jalankan. Catat hasilnya. Sertakan bukti screen capture tampilan kemudian beri penjelasan.],
          [
            #figure(
              image("ss01_localhost.png", width: 90%),
              caption: [Tampilan localhost:8000 saat server dijalankan]
            )

            Muncul halaman *"Not Found"* dengan pesan _"The requested resource / was not found on this server."_ di `localhost:8000`. Ini karena PHP Built-in Server tidak memiliki fitur directory listing seperti Laragon atau NGINX, sehingga mengakses root `/` tanpa file `index.html` langsung menghasilkan 404. Server tetap berjalan normal dan file HTML dapat diakses langsung lewat path lengkapnya, misalnya `localhost:8000/hello.html`.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 2: Memulai HTML",
      deskripsi: [
        Membuat file HTML pertama dengan nama `hello.html` menggunakan struktur dasar HTML dan tag `<br>` untuk membuat baris baru.

        ```html
        <html>
            <head>
                <title>My First HTML Document</title>
            </head>
            <body>
                <p>
                    Hellow World<br>Welcome to my <b>First</b> HTML Document
                </p>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `hello.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss02_hello.png", width: 90%),
              caption: [Tampilan hello.html di browser]
            )

            Muncul blank page putih dan di pojok kiri atas ada teks "Hellow World" lalu di baris bawahnya ada "Welcome to my *First* HTML Document" (kata First dicetak tebal).
          ],
        ),
        (
          [Hilangkan tag `<br>` pada kode, amati perbedaannya dan sampaikan apakah fungsi tag `<br>`.],
          [
            #figure(
              image("ss03_hello_nobr.png", width: 90%),
              caption: [Tampilan hello.html setelah tag \<br\> dihilangkan]
            )

            Setelah tag `<br>` dihilangkan, teks "Hellow World" dan "Welcome to my First HTML Document" yang tadinya terpisah baris jadi tampil dalam satu baris yang nyambung. Jadi fungsi tag `<br>` adalah untuk membuat baris baru (_line break_) dalam HTML.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 3: Heading",
      deskripsi: [
        Membuat file `heading.html` untuk menampilkan enam level heading, lalu `headingAlign.html` untuk mengatur alignment tiap heading.

        ```html
        <html>
            <body>
                <h1>Heading 1</h1>
                <h2>Heading 2</h2>
                <h3>Heading 3</h3>
                <h4>Heading 4</h4>
                <h5>Heading 5</h5>
                <h6>Heading 6</h6>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `heading.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss04_heading.png", width: 90%),
              caption: [Tampilan heading.html di browser]
            )

            Muncul 6 level heading dari H1 sampai H6 secara berurutan dari atas ke bawah. Ukuran teksnya semakin mengecil dari H1 ke H6, semuanya rata kiri.
          ],
        ),
        (
          [Amati apa yang muncul pada browser ketika membuka `headingAlign.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss05_heading_align.png", width: 90%),
              caption: [Tampilan headingAlign.html di browser]
            )

            Heading 1 jadi rata kanan, Heading 2 jadi rata tengah, Heading 3 tetap rata kiri. Untuk H4, H5, H6 yang tidak diberi atribut `align` tetap menggunakan default rata kiri.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 4: Paragraf",
      deskripsi: [
        Membuat file `paragraf.html` untuk menampilkan beberapa paragraf, lalu `paragrafAlign.html` untuk mengatur alignment tiap paragraf.

        ```html
        <html>
            <body>
                <p>ini paragraf pertama</p>
                <p>ini paragraf kedua kedua kedua ...</p>
                <p>ini paragraf ketiga</p>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `paragraf.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss06_paragraf.png", width: 90%),
              caption: [Tampilan paragraf.html di browser]
            )

            Muncul 3 paragraf teks yang terpisah satu sama lain. Paragraf pertama "ini paragraf pertama", paragraf kedua berisi teks yang diulang-ulang, dan paragraf ketiga "ini paragraf ketiga". Antar paragraf ada jarak otomatis dari tag `<p>`.
          ],
        ),
        (
          [Amati apa yang muncul pada browser ketika membuka `paragrafAlign.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss07_paragraf_align.png", width: 90%),
              caption: [Tampilan paragrafAlign.html di browser]
            )

            Paragraf pertama jadi rata kanan, paragraf kedua (yang teksnya panjang) jadi rata tengah, dan paragraf ketiga rata kiri sesuai nilai atribut `align` yang diberikan.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 5: Format Font",
      deskripsi: [
        Membuat file `font.html` untuk menampilkan berbagai tag pemformatan teks dalam HTML.

        ```html
        <html>
            <body>
                <b>Menggunakan Tag &lt;b&gt;</b><br>
                <strong>Menggunakan Tag &lt;strong&gt;</strong><br>
                <i>Menggunakan Tag &lt;i&gt;</i><br>
                <em>Menggunakan Tag &lt;em&gt;</em><br>
                <u>Menggunakan Tag &lt;u&gt;</u><br>
                <strike>Menggunakan Tag &lt;strike&gt;</strike><br>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `font.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss08_font.png", width: 90%),
              caption: [Tampilan font.html di browser]
            )

            Muncul beberapa baris teks dengan format yang berbeda-beda: teks tebal dengan `<b>`, teks tebal dengan `<strong>`, teks miring dengan `<i>`, teks miring dengan `<em>`, teks bergaris bawah dengan `<u>`, dan teks dicoret dengan `<strike>`.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 6: Karakter Khusus",
      deskripsi: [
        Membuat file `karakter.html` untuk menampilkan karakter-karakter khusus menggunakan HTML entities.

        ```html
        <html>
            <body>
                &pound; Pound <br>
                &euro; Euro <br>
                &copy; Copyright <br>
                &reg; Registered <br>
                &trade; Trademark <br>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `karakter.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss09_karakter.png", width: 90%),
              caption: [Tampilan karakter.html di browser]
            )

            Muncul daftar karakter khusus: simbol Pound (£), Euro (€), Copyright (©), Registered (®), dan Trademark (™), masing-masing diikuti nama karakternya.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 7: Garis Horizontal",
      deskripsi: [
        Membuat file `garishorizontal.html` untuk menampilkan penggunaan tag `<hr>` sebagai garis pemisah konten.

        ```html
        <html>
            <body>
                Membuat garis horizontal <hr>
                Lorem ipsum dolor sit amet ...
                <hr>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `garishorizontal.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss10_garis.png", width: 90%),
              caption: [Tampilan garishorizontal.html di browser]
            )

            Muncul teks "Membuat garis horizontal" lalu ada garis horizontal (`<hr>`), diikuti teks Lorem ipsum panjang, lalu ditutup dengan garis horizontal lagi di bagian bawah.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 8: List",
      deskripsi: [
        Membuat file `list.html` untuk menampilkan tiga jenis list dalam HTML: ordered list, unordered list, dan definition list.

        ```html
        <html>
            <body>
                Ordered list
                <ol>
                    <li>satu</li>
                    <li>dua</li>
                    <li>tiga</li>
                </ol>
                Unordered list
                <ul>
                    <li>apel</li>
                    <li>pisang</li>
                    <li>mangga</li>
                </ul>
                <br><hr>
                Definition list
                <dl>
                    <dt>satu</dt>
                    <dd>satu satu</dd>
                    <dd>satu dua</dd>
                    <dt>dua</dt>
                    <dd>dua dua</dd>
                </dl>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `list.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss11_list.png", width: 90%),
              caption: [Tampilan list.html di browser]
            )

            Muncul tiga jenis list yang berbeda: ordered list dengan angka (1. satu, 2. dua, 3. tiga), unordered list dengan bullet (apel, pisang, mangga), dan definition list (satu -> satu satu, satu dua; dua -> dua dua). Antar jenis list dipisahkan garis horizontal.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 9: Pewarnaan",
      deskripsi: [
        Membuat file `warna.html` untuk menampilkan penggunaan warna pada background halaman dan teks menggunakan nama warna dan kode heksadesimal.

        ```html
        <html>
            <body bgcolor="aqua">
                <h3 align="center">Heading 3</h3>
                <font color="red">Font berwarna merah</font><br><br>
                <font color="#FF0000">Font berwarna merah menggunakan nilai heksa</font>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang muncul pada browser ketika membuka `warna.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss12_warna.png", width: 90%),
              caption: [Tampilan warna.html di browser]
            )

            Background halaman berwarna aqua (cyan). Ada teks "Heading 3" di tengah, lalu dua baris teks merah -- yang pertama ditulis dengan nama warna `"red"` dan yang kedua dengan kode heksadesimal `"#FF0000"`, tampilannya sama-sama merah.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 10: Gambar",
      deskripsi: [
        Membuat file `gambar.html` untuk menampilkan gambar dengan dua cara: path langsung di folder yang sama dan path ke subfolder.

        ```html
        <html>
            <body>
                <p align="center">
                    <img src="bunga2.png" alt="bunga2">
                    Lorem ipsum ...
                    <hr>
                </p>
                <p>
                    <img src="img/bunga1.png" alt="bunga1">
                    Lorem ipsum ...
                </p>
            </body>
        </html>
        ```
      ],
      langkah: (),
      pertanyaan: (
        (
          [Catat hasil pengamatanmu terhadap dua cara memunculkan gambar dalam halaman web.],
          [
            #figure(
              image("ss13_gambar.png", width: 90%),
              caption: [Tampilan gambar.html di browser]
            )

            Dua cara menampilkan gambar dalam HTML: pertama dengan path langsung di folder yang sama (`src="bunga2.png"`), dan kedua dengan path ke subfolder (`src="img/bunga1.png"`). Keduanya bisa menampilkan gambar dengan normal, perbedaannya hanya di lokasi penyimpanan filenya.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 11: Macam-Macam Link",
      deskripsi: [
        Membuat file `macamLink.html` untuk menampilkan empat jenis hyperlink dalam HTML: link relatif, link absolut, link ke jendela baru, dan link ke email. Setiap section dilengkapi dengan anchor agar bisa diakses dari daftar isi di atas halaman.
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang tampil pada browser dan bagaimana tiap link bekerja. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss14a_link.png", width: 90%),
              caption: [Tampilan macamLink.html -- halaman utama dengan daftar link]
            )
            #figure(
              image("ss14b_link_relatif.png", width: 90%),
              caption: [Section link relatif]
            )
            #figure(
              image("ss14c_link_absolut.png", width: 90%),
              caption: [Section link absolut]
            )
            #figure(
              image("ss14d_link_newwindow.png", width: 90%),
              caption: [Section link dengan new window]
            )
            #figure(
              image("ss14e_link_email.png", width: 90%),
              caption: [Section link ke email]
            )

            Tampil halaman dengan 4 jenis link. Link relatif mengarah ke halaman lain dalam folder yang sama. Link absolut mengarah ke URL eksternal (`https://google.com`). Link "new window" membuka halaman di tab/jendela baru dengan atribut `target="_blank"`. Link email membuka aplikasi email dengan `href="mailto:..."`. Di tiap section juga ada link "kembali ke menu" yang menggunakan anchor untuk kembali ke bagian atas halaman.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 12: Membuat Tabel",
      deskripsi: [
        Membuat file `buatTabel.html` dan secara bertahap menambahkan berbagai atribut tabel: border, height, width, cellpadding, cellspacing, align, valign, font, colspan, dan rowspan.
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang tampil pada browser ketika membuka `buatTabel.html`. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss15_tabel_noborder.png", width: 90%),
              caption: [Tampilan buatTabel.html tanpa border]
            )

            Muncul tabel tanpa garis/border, berisi 2 baris dan 2 kolom. Isinya: "ini baris pertama kolom pertama", "ini baris pertama kolom kedua", "ini baris kedua kolom pertama", "ini baris kedua kolom kedua". Karena tidak ada border, terlihat seperti teks biasa yang tersusun rapi saja.
          ],
        ),
        (
          [Tambahkan atribut `border=1` pada tag `<table>`. Amati apa yang berubah pada tampilan. Catat hasil pengamatanmu.],
          [
            #figure(
              image("ss16_tabel_border.png", width: 90%),
              caption: [Tampilan buatTabel.html setelah border=1 ditambahkan]
            )

            Setelah `border=1` ditambahkan, tabel sekarang punya garis tepi yang terlihat jelas di setiap sel. Tampilannya jadi lebih seperti tabel pada umumnya.
          ],
        ),
        (
          [Tambahkan satu baris dalam tabel dan tambahkan satu kolom di dalamnya. Tulis kode program `buatTabel.html` yang baru saja Anda ubah.],
          [
            #figure(
              image("ss17_tabel_baris3.png", width: 90%),
              caption: [Tampilan buatTabel.html setelah baris ketiga ditambahkan]
            )

            ```html
            <html>
                <head><title>Membuat tabel</title></head>
                <body>
                    <table border="1">
                        <tr>
                            <td>ini baris pertama kolom pertama</td>
                            <td>ini baris pertama kolom kedua</td>
                        </tr>
                        <tr>
                            <td>ini baris kedua kolom pertama</td>
                            <td>ini baris kedua kolom kedua</td>
                        </tr>
                        <tr>
                            <td>ini baris ketiga kolom pertama</td>
                        </tr>
                    </table>
                </body>
            </html>
            ```
          ],
        ),
        (
          [Tambahkan atribut `height=100% width=40%` pada tag `<table>`. Catat di sini perubahannya.],
          [
            #figure(
              image("ss18_tabel_width.png", width: 90%),
              caption: [Tampilan tabel setelah height=100% width=40% ditambahkan]
            )

            Tabel jadi lebih sempit, lebarnya hanya sekitar 40% dari lebar halaman browser. Tinggi tabel mengikuti konten yang ada di dalamnya.
          ],
        ),
        (
          [Hapus tanda `%` pada height dan width sehingga menjadi `height=100 width=40`. Apa yang anda pahami dari perbedaan penggunaan `%` dan penghilangan `%`?],
          [
            #figure(
              image("ss19_tabel_nopct.png", width: 90%),
              caption: [Tampilan tabel setelah tanda % dihapus dari height dan width]
            )

            Kalau pakai `%`, ukuran tabel menyesuaikan dengan ukuran jendela browser (relatif). Kalau tanpa `%`, ukurannya jadi nilai piksel tetap (absolut), sehingga tabel tampak jauh lebih kecil karena 40px lebar dan 100px tinggi itu sangat kecil di layar.
          ],
        ),
        (
          [Tambahkan atribut `cellpadding=20`. Catat di sini perubahannya.],
          [
            #figure(
              image("ss20_tabel_padding.png", width: 90%),
              caption: [Tampilan tabel setelah cellpadding=20 ditambahkan]
            )

            Ada jarak/ruang di dalam tiap sel antara isi teks dengan garis border selnya. Sel-sel jadi kelihatan lebih lega dan tidak mepet ke garis tepinya.
          ],
        ),
        (
          [Tambahkan atribut `cellspacing=5`. Catat di sini perubahannya.],
          [
            #figure(
              image("ss21_tabel_spacing.png", width: 90%),
              caption: [Tampilan tabel setelah cellspacing=5 ditambahkan]
            )

            Muncul jarak antar sel-sel di dalam tabel. Jadi antar sel ada celah/ruang yang terlihat, berbeda dari sebelumnya yang sel-selnya langsung menempel satu sama lain.
          ],
        ),
        (
          [Tambahkan atribut `align=right` pada kolom 1 baris 1. Catat di sini hasil pengamatanmu.],
          [
            #figure(
              image("ss22_tabel_align.png", width: 90%),
              caption: [Tampilan tabel setelah align=right ditambahkan pada sel pertama]
            )

            Teks "ini baris pertama kolom pertama" sekarang rata kanan di dalam selnya, sementara sel-sel lain masih rata kiri seperti biasa.
          ],
        ),
        (
          [Tambahkan `height=100%` `width=40%` dan `valign=bottom` pada kolom 1 baris 1. Catat di sini hasil pengamatanmu.],
          [
            #figure(
              image("ss23_tabel_valign.png", width: 90%),
              caption: [Tampilan tabel setelah valign=bottom ditambahkan]
            )

            Teks "ini baris pertama kolom pertama" sekarang berada di pojok kanan bawah selnya, karena kombinasi `align=right` dan `valign=bottom`. Sel pertama jadi kelihatan tinggi dan teksnya turun ke bawah.
          ],
        ),
        (
          [Tambahkan tag `<font>` di dalam tag `<td>` pada baris pertama kolom pertama. Catat di sini hasil pengamatanmu.],
          [
            #figure(
              image("ss24_tabel_font.png", width: 90%),
              caption: [Tampilan tabel setelah tag font ditambahkan pada sel pertama]
            )

            Teks di sel pertama tampilannya berubah, font-nya jadi berbeda (courier) dari sel-sel lainnya yang masih pakai font default browser.
          ],
        ),
        (
          [Ubah warna tulisan "ini baris pertama kolom pertama" menjadi warna merah, ukuran=15. Tulis kode yang berubah.],
          [
            #figure(
              image("ss25_tabel_merah.png", width: 90%),
              caption: [Tampilan tabel setelah teks diubah menjadi merah ukuran 15]
            )

            ```html
            <td rowspan="2" align="right" valign="bottom">
                <font face="courier" color="red" size="15">
                    ini baris pertama kolom pertama
                </font>
            </td>
            ```
          ],
        ),
        (
          [Tambahkan atribut `colspan="2"` pada baris kedua kolom 1, kemudian tambahkan 1 kolom pada baris pertama. Catat/sertakan tampilan hasilnya.],
          [
            #figure(
              image("ss26_tabel_colspan.png", width: 90%),
              caption: [Tampilan tabel setelah colspan dan kolom baru ditambahkan]
            )

            Baris pertama sekarang punya 3 kolom (kolom pertama + kolom kedua lama + 1 kolom baru "tambah 1 kolom"). Baris kedua kolom pertamanya melebar menggabungkan 2 kolom karena `colspan="2"`.
          ],
        ),
        (
          [Tambahkan 1 kolom lagi di baris kedua. Catat/sertakan tampilan hasilnya.],
          [
            #figure(
              image("ss27_tabel_kolom2.png", width: 90%),
              caption: [Tampilan tabel setelah 1 kolom tambahan di baris kedua]
            )

            Baris kedua sekarang punya tambahan 1 kolom lagi di sebelah kolom yang pakai `colspan="2"`, jadi tampilan baris kedua jadi punya lebih banyak kolom dan terlihat asimetris dengan baris pertama.
          ],
        ),
        (
          [Tambahkan atribut `rowspan="2"` pada baris kedua kolom pertama. Amati perubahannya.],
          [
            #figure(
              image("ss28_tabel_rowspan2.png", width: 90%),
              caption: [Tampilan tabel setelah rowspan pada baris kedua kolom pertama]
            )

            Sel di baris kedua kolom pertama melebar ke bawah, menggabungkan 2 baris secara vertikal. Sel tersebut kelihatan "panjang" memanjang ke bawah.
          ],
        ),
        (
          [Tambahkan `rowspan="2"` pada baris pertama kolom pertama. Amati perbedaannya dengan langkah sebelumnya.],
          [
            #figure(
              image("ss29_tabel_rowspan1.png", width: 90%),
              caption: [Tampilan tabel setelah rowspan dipindahkan ke baris pertama kolom pertama]
            )

            Perbedaannya ada di posisi sel yang digabungkan. Kalau `rowspan="2"` di baris kedua, sel yang memanjang ada di tengah ke bawah. Kalau `rowspan="2"` di baris pertama, sel yang memanjang mulai dari baris paling atas, jadi kolom pertama dari baris 1 langsung menggabungkan baris 1 dan baris 2.
          ],
        ),
      ),
    ),

    (
      subbab: "Percobaan 13: Membuat Form",
      deskripsi: [
        Membuat file `buatForm.html` dan secara bertahap menambahkan elemen-elemen form: input text, checkbox, radio button, select/dropdown, input password, dan textarea.
      ],
      langkah: (),
      pertanyaan: (
        (
          [Amati apa yang tampil pada browser ketika membuka `buatForm.html`. Catat hasil pengamatan dan pemahamanmu.],
          [
            #figure(
              image("ss30_form.png", width: 90%),
              caption: [Tampilan buatForm.html awal]
            )

            Muncul form sederhana dengan judul "FORM", ada input text untuk nama, checkbox "Are you student?", radio button pilihan umur (10-15, 16-20, 21-25), dan dua tombol di bawahnya yaitu "submit" dan "reset". Form ini adalah contoh dasar bagaimana HTML bisa menerima input dari pengguna sebelum datanya diproses.
          ],
        ),
        (
          [Tambahkan satu input text untuk memasukkan alamat di bawah input nama. Catat kode program yang anda tambahkan.],
          [
            #figure(
              image("ss31_form_alamat.png", width: 90%),
              caption: [Tampilan form setelah input alamat ditambahkan]
            )

            ```html
            <input type="text" name="var2" size="30" value="Enter your address here">
            ```
          ],
        ),
        (
          [Apakah tampilan pada browser menjadi seperti gambar di modul?],
          [
            #figure(
              image("ss32_form_kendaraan.png", width: 90%),
              caption: [Tampilan form setelah checkbox kendaraan ditambahkan]
            )

            Ya, tampilan sudah sesuai dengan yang ada di modul. Checkbox kendaraan (bike, car, boat) sudah muncul di bawah radio button pilihan umur.
          ],
        ),
        (
          [Tambahkan satu input checkbox berisi "I have a plane". Tuliskan kode seluruh pengaturan checkbox.],
          [
            #figure(
              image("ss33_form_plane.png", width: 90%),
              caption: [Tampilan form setelah checkbox "I have a plane" ditambahkan]
            )

            ```html
            <input type="checkbox" name="vehicle1" value="bike"> i have a bike
            <br>
            <input type="checkbox" name="vehicle2" value="car"> i have a car
            <br>
            <input type="checkbox" name="vehicle3" value="boat"> i have a boat
            <br>
            <input type="checkbox" name="vehicle4" value="plane" checked> i have a plane
            ```
          ],
        ),
        (
          [Catat di sini apa yang dimaksud dengan potongan program (cara kerja) pada elemen `<select>` yang ditambahkan.],
          [
            Elemen `<select>` digunakan untuk membuat dropdown menu pilihan. Atribut `name` digunakan sebagai identifier datanya, `size="1"` berarti hanya satu pilihan yang terlihat sekaligus (dropdown biasa). Di dalamnya ada beberapa `<option>` yang masing-masing punya `value` sebagai data yang dikirim dan teks yang ditampilkan ke user. Atribut `selected` pada salah satu `<option>` menentukan pilihan default yang sudah terpilih saat halaman dibuka.
          ],
        ),
        (
          [Tambahkan pilihan Indonesia dan jadikan sebagai default. Catat di sini perubahannya.],
          [
            #figure(
              image("ss35_form_indonesia.png", width: 90%),
              caption: [Tampilan dropdown setelah Indonesia ditambahkan sebagai default]
            )

            Dropdown sekarang punya pilihan Indonesia di dalamnya, dan saat halaman pertama dibuka pilihan yang sudah terpilih otomatis adalah Indonesia karena diberi atribut `selected`.
          ],
        ),
        (
          [Ubah nilai `size=1` menjadi `size=2`. Catat di sini perubahannya.],
          [
            #figure(
              image("ss36_form_size2.png", width: 90%),
              caption: [Tampilan dropdown setelah size diubah menjadi 2]
            )

            Dropdown yang tadinya hanya menampilkan satu pilihan sekarang menampilkan dua pilihan sekaligus dalam kotak (Bulgaria dan United Kingdom terlihat langsung, sisanya bisa di-scroll).
          ],
        ),
        (
          [Tambahkan input tipe password dan textarea untuk komentar panjang. Catat di sini kode yang anda tambahkan.],
          [
            #figure(
              image("ss37a_form_password.png", width: 90%),
              caption: [Tampilan form setelah input password ditambahkan]
            )
            #figure(
              image("ss37b_form_textarea.png", width: 90%),
              caption: [Tampilan form lengkap setelah textarea ditambahkan]
            )

            ```html
            <b>Enter your private code</b>
            <input type="password">
            <br><br>
            <b>Enter your comment</b>
            <br>
            <textarea name="comment" cols="30" rows="5">fill this area</textarea>
            ```
          ],
        ),
        (
          [Ubah method dari POST menjadi GET. Amati dan bandingkan perbedaan antara method GET dan POST.],
          [
            #figure(
              image("ss38a_get.png", width: 90%),
              caption: [Tampilan URL setelah form dikirim dengan method GET]
            )
            #figure(
              image("ss38b_post.png", width: 90%),
              caption: [Tampilan URL setelah form dikirim dengan method POST]
            )

            Perbedaan yang terlihat jelas ada di URL browser setelah tombol Send diklik. Kalau pakai GET, semua data yang diisi di form tampil langsung di URL dalam bentuk query string (misalnya `?var1=Rafi&var2=jl.+rawi+indah...`). Kalau pakai POST, URL tidak berubah dan tidak ada data yang terlihat di address bar -- data dikirim secara tersembunyi di body request. Jadi GET lebih transparan tapi kurang aman untuk data sensitif, sedangkan POST datanya tidak terekspos di URL.
          ],
        ),
      ),
    ),
  ))

  #tugas(data: (
    (
      subbab: "Tugas Praktikum 10: Gambar Sebagai Link",
      konten: [
        Membuat file `tugasLink.html` yang menampilkan sebuah gambar yang berfungsi sebagai hyperlink. Ketika gambar diklik, browser akan membuka halaman `www.google.com`.

        ```html
        <html>
            <head>
                <title>Tugas Praktikum 10</title>
            </head>
            <body>
                <h3>Sebuah gambar yang mengandung link</h3>
                <a href="http://www.google.com">
                    <img src="img/bunga1.png" alt="bunga link">
                </a>
                <p>ini adalah gambar bunga yang mengandung link,
                jika kamu mengklik gambar ini maka kamu akan dibawa
                ke website google.com</p>
            </body>
        </html>
        ```

        #figure(
          image("ss_tugas.png", width: 90%),
          caption: [Tampilan tugasLink.html -- gambar bunga sebagai hyperlink ke google.com]
        )
      ],
    ),
  ))
]
