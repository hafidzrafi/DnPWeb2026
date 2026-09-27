/**
 * Jobsheet 05 - JavaScript DOM & Event
 * SIMPUS-Mini Starter Skeleton
 */

// ===== 1. Hamburger Menu (DOM Manipulation & Event Listener) =====
function initNavToggle() {
    // TODO: Ambil elemen tombol '#nav-toggle-btn' dan elemen 'header nav'
    // TODO: Tambahkan event listener 'click' pada tombol toggle
    // TODO: Toggle class 'nav-open' pada elemen nav saat tombol diklik
}

// ===== 2. Konfirmasi Hapus (Event Handling) =====
function initHapusConfirm() {
    // TODO: Seleksi semua tombol dengan class '.btn-hapus'
    // TODO: Pasang event listener 'click' pada setiap tombol
    // TODO: Tampilkan dialog confirm() sebelum menghapus baris tabel terkait
}

// ===== 3. Filter/Pencarian Tabel Real-Time (Keyboard Event & DOM Traversal) =====
function initTableFilter() {
    // TODO: Ambil elemen input pencarian '#search-input' dan tabel data
    // TODO: Pasang event listener 'keyup' atau 'input'
    // TODO: Lakukan iterasi baris <tr> pada <tbody> dan sembunyikan baris yang tidak cocok dengan kata kunci
}

// ===== 4. Validasi Form Sisi Klien (Form Event & Error Handling) =====
function tampilkanError(input, pesan) {
    // TODO: Tampilkan pesan error (misal buat elemen span.error di bawah input)
}

function hapusError(input) {
    // TODO: Hapus pesan error jika input sudah valid
}

function initValidasiForm() {
    // TODO: Ambil elemen form '#form-tambah'
    // TODO: Pasang event listener 'submit'
    // TODO: Lakukan validasi field wajib (judul/nama, pengarang, tahun, stok)
    // TODO: Jika tidak valid, panggil e.preventDefault() dan tampilkan pesan error
}

// Inisialisasi saat seluruh dokumen DOM selesai dimuat
document.addEventListener("DOMContentLoaded", function () {
    initNavToggle();
    initHapusConfirm();
    initTableFilter();
    initValidasiForm();
});
