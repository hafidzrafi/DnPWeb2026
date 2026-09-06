# Jobsheet 1 — Answers
**Matkul:** Desain dan Pemrograman Web | **Polinema TI, 2026**

---

## Soal 1
Buka browser Anda, ketikkan localhost kemudian jalankan. Catat hasilnya. Sertakan bukti screen capture tampilan kemudian beri penjelasan.

muncul halaman "Not Found" dengan pesan *"The requested resource / was not found on this server."* di `localhost:8000`. Ini karena pada praktikum ini digunakan PHP Built-in Server sebagai pengganti Laragon (yang hanya tersedia di Windows), dijalankan dengan perintah `php -S localhost:8000` dari direktori jobsheet. PHP Built-in Server tidak memiliki fitur directory listing seperti Laragon/NGINX, sehingga mengakses root `/` tanpa file `index.html` langsung menghasilkan 404. Server tetap berjalan normal dan file HTML bisa diakses langsung lewat path lengkapnya, misalnya `localhost:8000/hello.html`.

## Soal 2
Amati apa yang muncul pada browser ketika membuka `hello.html`. Catat hasil pengamatanmu.

muncul blank page putih dan di pojok kiri atas ada teks "Hellow World" lalu di baris bawahnya ada "Welcome to my **First** HTML Document" (kata First dicetak tebal).

## Soal 3
Hilangkan tag `<br>` pada kode, amati perbedaannya dan sampaikan apakah fungsi tag `<br>`.

setelah tag `<br>` dihilangkan, teks "Hellow World" dan "Welcome to my First HTML Document" yang tadinya terpisah baris jadi tampil dalam satu baris yang nyambung. jadi fungsi tag `<br>` adalah untuk membuat baris baru (line break) dalam HTML.

## Soal 4
Amati apa yang muncul pada browser ketika membuka `heading.html`. Catat hasil pengamatanmu.

muncul 6 level heading dari H1 sampai H6 secara berurutan dari atas ke bawah. ukuran teksnya semakin mengecil dari H1 ke H6, semuanya rata kiri.

## Soal 5
Amati apa yang muncul pada browser ketika membuka `headingAlign.html`. Catat hasil pengamatanmu.

heading 1 jadi rata kanan, heading 2 jadi rata tengah, heading 3 tetap rata kiri. untuk H4, H5, H6 yang tidak diberi atribut `align` tetap menggunakan default rata kiri.

## Soal 6
Amati apa yang muncul pada browser ketika membuka `paragraf.html`. Catat hasil pengamatanmu.

muncul 3 paragraf teks yang terpisah satu sama lain. paragraf pertama "ini paragraf pertama", paragraf kedua berisi teks yang diulang-ulang, dan paragraf ketiga "ini paragraf ketiga". antar paragraf ada jarak otomatis dari tag `<p>`.

## Soal 7
Amati apa yang muncul pada browser ketika membuka `paragrafAlign.html`. Catat hasil pengamatanmu.

paragraf pertama jadi rata kanan, paragraf kedua (yang teksnya panjang) jadi rata tengah, dan paragraf ketiga rata kiri sesuai nilai atribut `align` yang diberikan.

## Soal 8
Amati apa yang muncul pada browser ketika membuka `font.html`. Catat hasil pengamatanmu.

muncul beberapa baris teks dengan format yang berbeda-beda: teks tebal dengan `<b>`, teks tebal dengan `<strong>`, teks miring dengan `<i>`, teks miring dengan `<em>`, teks bergaris bawah dengan `<u>`, dan teks dicoret dengan `<strike>`.

## Soal 9
Amati apa yang muncul pada browser ketika membuka `karakter.html`. Catat hasil pengamatanmu.

muncul daftar karakter khusus: simbol Pound (£), Euro (€), Copyright (©), Registered (®), dan Trademark (™), masing-masing diikuti nama karakternya.

## Soal 10
Amati apa yang muncul pada browser ketika membuka `garishorizontal.html`. Catat hasil pengamatanmu.

muncul teks "Membuat garis horizontal" lalu ada garis horizontal (`<hr>`), diikuti teks Lorem ipsum panjang, lalu ditutup dengan garis horizontal lagi di bagian bawah.

## Soal 11
Amati apa yang muncul pada browser ketika membuka `list.html`. Catat hasil pengamatanmu.

muncul tiga jenis list yang berbeda: ordered list dengan angka (1. satu, 2. dua, 3. tiga), unordered list dengan bullet (apel, pisang, mangga), dan definition list (satu → satu satu, satu dua; dua → dua dua). antar jenis list dipisahkan garis horizontal.

## Soal 12
Amati apa yang muncul pada browser ketika membuka `warna.html`. Catat hasil pengamatanmu.

background halaman berwarna aqua (cyan). ada teks "Heading 3" di tengah, lalu dua baris teks merah — yang pertama ditulis dengan nama warna `"red"` dan yang kedua dengan kode heksadesimal `"#FF0000"`, tampilannya sama-sama merah.

## Soal 13
Catat hasil pengamatanmu terhadap dua cara memunculkan gambar dalam halaman web.

dua cara menampilkan gambar dalam HTML: pertama dengan path langsung di folder yang sama (`src="bunga2.png"`), dan kedua dengan path ke subfolder (`src="img/bunga1.png"`). keduanya bisa menampilkan gambar dengan normal, perbedaannya hanya di lokasi penyimpanan filenya.

## Soal 14
Amati apa yang tampil pada browser dan bagaimana tiap link bekerja. Catat hasil pengamatanmu.

tampil halaman dengan 4 jenis link. link relatif mengarah ke halaman lain dalam folder yang sama. link absolut mengarah ke URL eksternal (`https://google.com`). link "new window" membuka halaman di tab/jendela baru dengan atribut `target="_blank"`. link email membuka aplikasi email dengan `href="mailto:..."`. di tiap section juga ada link "kembali ke menu" yang menggunakan anchor (`#TOP`) untuk kembali ke bagian atas halaman.

## Soal 15
Amati apa yang tampil pada browser ketika membuka `buatTabel.html`. Catat hasil pengamatanmu.

muncul tabel tanpa garis/border, berisi 2 baris dan 2 kolom. isinya: "ini baris pertama kolom pertama", "ini baris pertama kolom kedua", "ini baris kedua kolom pertama", "ini baris kedua kolom kedua". karena tidak ada border, terlihat seperti teks biasa yang tersusun rapi saja.

## Soal 16
Tambahkan atribut `border=1` pada tag `<table>`. Amati apa yang berubah pada tampilan. Catat hasil pengamatanmu.

setelah `border=1` ditambahkan, tabel sekarang punya garis tepi yang terlihat jelas di setiap sel. tampilannya jadi lebih seperti tabel pada umumnya.

## Soal 17
Tambahkan satu baris dalam tabel yang dibuat sebelumnya dan tambahkan satu kolom di dalamnya. Tulis kode program `buatTabel.html` yang baru saja Anda ubah.

```html
<html>
    <head>
        <title>
            Membuat tabel
        </title>
    </head>
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

## Soal 18
Dari kode yang anda ubah di soal no 17, tambahkan atribut pada tag `<table>` berupa `height=100% width=40%`. Catat di sini perubahannya.

tabel jadi lebih sempit, lebarnya hanya sekitar 40% dari lebar halaman browser. tinggi tabel mengikuti konten yang ada di dalamnya.

## Soal 19
Dari kode program yang anda ubah di langkah 12, hapus tanda `%` pada height dan width, sehingga menjadi `height=100 width=40`. Apa yang anda pahami dari perbedaan penggunaan `%` dan penghilangan `%` pada kode program tersebut. Catat di sini.

kalau pakai `%`, ukuran tabel menyesuaikan dengan ukuran jendela browser (relatif). kalau tanpa `%`, ukurannya jadi nilai piksel tetap (absolut), sehingga tabel tampak jauh lebih kecil karena 40px lebar dan 100px tinggi itu sangat kecil di layar.

## Soal 20
Dari kode program yang anda ubah pada langkah 15, tambahkan atribut `cellpadding=20`. Catat di sini perubahannya.

ada jarak/ruang di dalam tiap sel antara isi teks dengan garis border selnya. sel-sel jadi kelihatan lebih lega dan tidak mepet ke garis tepinya.

## Soal 21
Dari kode program yang anda ubah pada langkah 18, tambahkan atribut `cellspacing=5`. Catat di sini perubahannya.

muncul jarak antar sel-sel di dalam tabel. jadi antar sel ada celah/ruang yang terlihat, berbeda dari sebelumnya yang sel-selnya langsung menempel satu sama lain.

## Soal 22
Pada kode program yang digunakan untuk mengatur kolom 1 dari baris 1, tambahkan atribut `align=right`, sehingga kode pada bagian tersebut menjadi `<td align=right>`. Catat di sini hasil pengamatanmu.

teks "ini baris pertama kolom pertama" sekarang rata kanan di dalam selnya, sementara sel-sel lain masih rata kiri seperti biasa.

## Soal 23
Tambahkan `%` pada height dan width sehingga menjadi `height=100%` dan `width=40%`, kemudian tambahkan atribut `valign=bottom` pada kolom 1 baris 1. Catat di sini hasil pengamatanmu.

teks "ini baris pertama kolom pertama" sekarang berada di pojok kanan bawah selnya, karena kombinasi `align=right` dan `valign=bottom`. sel pertama jadi kelihatan tinggi dan teksnya turun ke bawah.

## Soal 24
Dari kode program pada langkah 28, tambahkan pengaturan font pada isi baris pertama kolom pertama dengan menambahkan tag `<font>` di dalam tag `<td>`. Catat di sini hasil pengamatanmu.

teks di sel pertama tampilannya berubah, font-nya jadi berbeda (courier) dari sel-sel lainnya yang masih pakai font default browser.

## Soal 25
Ubah warna tulisan "ini baris pertama kolom pertama" menjadi warna merah, ukuran=15. Tulis kode yang berubah sesuai langkah tersebut.

```html
<td rowspan="2" align="right" valign="bottom">
    <font face="courier" color="red" size="15">ini baris pertama kolom pertama</font>
</td>
```

## Soal 26
Dari kode program `buatTabel.html` setelah langkah 35 selesai, tambahkan atribut `colspan="2"` pada baris kedua kolom 1, kemudian tambahkan 1 kolom pada baris pertama. Catat/sertakan tampilan hasilnya.

baris pertama sekarang punya 3 kolom (kolom pertama + kolom kedua lama + 1 kolom baru "tambah 1 kolom"). baris kedua kolom pertamanya melebar menggabungkan 2 kolom karena `colspan="2"`.

## Soal 27
Kemudian tambahkan 1 kolom lagi di baris kedua. Catat/sertakan tampilan hasilnya.

baris kedua sekarang punya tambahan 1 kolom lagi di sebelah kolom yang pakai `colspan="2"`, jadi tampilan baris kedua jadi punya lebih banyak kolom dan terlihat asimetris dengan baris pertama.

## Soal 28
Tambahkan atribut `rowspan="2"` pada baris kedua kolom pertama. Simpan hasilnya jalankan pada browser dan amati perubahannya. Catat hasil pengamatanmu di sini.

sel di baris kedua kolom pertama melebar ke bawah, menggabungkan 2 baris secara vertikal. sel tersebut kelihatan "panjang" memanjang ke bawah.

## Soal 29
Tambahkan `rowspan="2"` pada baris pertama kolom pertama. Simpan dan jalankan pada browser. Amati apa perbedaannya antara kode program pada langkah 42 dan 45. Catat di sini hasil pengamatanmu.

perbedaannya ada di posisi sel yang digabungkan. kalau `rowspan="2"` di baris kedua, sel yang memanjang ada di tengah ke bawah. kalau `rowspan="2"` di baris pertama, sel yang memanjang mulai dari baris paling atas, jadi kolom pertama dari baris 1 langsung menggabungkan baris 1 dan baris 2.

## Soal 30
Amati apa yang tampil pada browser ketika membuka `buatForm.html`. Catat hasil pengamatan dan pemahamanmu.

muncul form sederhana dengan judul "FORM", ada input text untuk nama, checkbox "Are you student?", radio button pilihan umur (10-15, 16-20, 21-25), dan dua tombol di bawahnya yaitu "send" dan "clear". form ini adalah contoh dasar bagaimana HTML bisa menerima input dari pengguna sebelum datanya diproses.

## Soal 31
Tambahkan satu input text yang akan digunakan untuk memasukkan alamat, letakkan di bawah elemen input text untuk memasukkan nama. Catat kode program yang anda tambahkan.

```html
<input type="text" name="var2" size="30" value="Enter your address here">
```

## Soal 32
Apakah tampilan pada browser menjadi seperti gambar di modul?

Jawab: Ya, tampilan sudah sesuai dengan yang ada di modul. checkbox kendaraan (bike, car, boat) sudah muncul di bawah radio button pilihan umur.

## Soal 33
Tambahkan satu input checkbox yang akan menampilkan pilihan berisi "I have a plane". Tuliskan di sini kode seluruh pengaturan checkbox termasuk kode pengaturan checkbox yang baru saja anda tambahkan.

```html
<input type="checkbox" name="vehicle1" value="bike"> i have a bike
<br>
<input type="checkbox" name="vehicle2" value="car"> i have a car
<br>
<input type="checkbox" name="vehicle3" value="boat"> i have a boat
<br>
<input type="checkbox" name="vehicle4" value="plane" checked> i have a plane
```

## Soal 34
Catat di sini apa yang dimaksud dengan potongan program (cara kerja) pada elemen `<select>` yang ditambahkan.

elemen `<select>` digunakan untuk membuat dropdown menu pilihan. atribut `name` digunakan sebagai identifier datanya, `size="1"` berarti hanya satu pilihan yang terlihat sekaligus (dropdown biasa). di dalamnya ada beberapa `<option>` yang masing-masing punya `value` sebagai data yang dikirim dan teks yang ditampilkan ke user. atribut `selected` pada salah satu `<option>` menentukan pilihan default yang sudah terpilih saat halaman dibuka.

## Soal 35
Dari kode program yang anda ubah, tambahkan satu pilihan negara yaitu Indonesia dan default pilihan berada di negara Indonesia. Catat di sini perubahannya.

dropdown sekarang punya pilihan Indonesia di dalamnya, dan saat halaman pertama dibuka pilihan yang sudah terpilih otomatis adalah Indonesia karena diberi atribut `selected`.

## Soal 36
Dari kode program pada langkah 17, ubah nilai `size=1` menjadi `size=2`. Catat di sini perubahannya.

dropdown yang tadinya hanya menampilkan satu pilihan sekarang menampilkan dua pilihan sekaligus dalam kotak (Bulgaria dan United Kingdom terlihat langsung, sisanya bisa di-scroll).

## Soal 37
Tambahkan sebuah single text area untuk memasukkan password (menggunakan input tipe password), kemudian tambahkan sebuah text area untuk mengetik komentar panjang menggunakan tag `<textarea>`. Catat di sini kode yang anda tambahkan.

```html
<b>Enter your private code</b>
<input type="password">
<br><br>
<b>Enter your comment</b>
<br>
<textarea name="comment" cols="30" rows="5">fill this area</textarea>
```

## Soal 38
Ubah method dari POST menjadi GET. Isi form lalu klik tombol Send. Amati dan bandingkan perbedaan antara method GET dan POST. Catat hasil pengamatanmu di sini.

perbedaan yang terlihat jelas ada di URL browser setelah tombol Send diklik. kalau pakai GET, semua data yang diisi di form tampil langsung di URL dalam bentuk query string (misalnya `?var1=Rafi&var2=jl.+rawi+indah...`). kalau pakai POST, URL tidak berubah dan tidak ada data yang terlihat di address bar — data dikirim secara tersembunyi di body request. jadi GET lebih transparan tapi kurang aman untuk data sensitif, sedangkan POST datanya tidak terekspos di URL.
