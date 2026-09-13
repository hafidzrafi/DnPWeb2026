# Jobsheet 1 (Session 01) — Answers: SIMPUS-Mini
**Matkul:** Desain dan Pemrograman Web | **Polinema TI, 2026**

---

## Refleksi 1
Kenapa field "Alamat" dan "No. HP" tidak diberi `required`, sedangkan "Nama" dan "No. Anggota" diberi?

Nama dan No. Anggota itu data identitas utama buat bedain antar peminjam di sistem perpustakaan, jadi wajib ada pas simpan data. Sedangkan Alamat sama No. HP sifatnya opsional/kontak pelengkap aja, jadi ga masalah kalau dikosongkan pas input data baru.

---

## Refleksi 2
Apa yang akan terjadi (di browser) kalau kamu klik tombol "Simpan" tanpa mengisi field "Nama"? Coba buka filenya di browser dan praktikkan.

Browser langsung nolak/ngeblok submit form dan nampilin pop-up tooltip validasi bawaan HTML5 yang isinya "Please fill out this field" persis di input field Nama. Kursor juga otomatis fokus ke field itu karena ada atribut `required`.

---

## Refleksi 3
Form ini juga belum punya action pada tag `<form>`-nya — apa dampaknya saat tombol "Simpan" ditekan?

Dampaknya form bakal ngirim data ke URL halaman itu sendiri (default behavior form tanpa action) dan cuma nge-reload halaman web tanpa ada proses simpan data ke database atau backend apa pun.
