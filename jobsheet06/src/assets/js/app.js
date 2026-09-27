/**
 * Jobsheet 06 - Fetch API & JSON
 * SIMPUS-Mini Starter Skeleton
 */

// ===== 1. Hamburger menu (DOM Manipulation) =====
function initNavToggle() {
    // TODO: Toggle nav-open class saat tombol #nav-toggle-btn diklik
}

// ===== 2. Konfirmasi Hapus Dinamis (Event Delegation) =====
// Menggunakan event delegation di document karena baris tabel
// dirender secara dinamis via fetch dari file JSON.
function initHapusConfirm() {
    // TODO: Pasang event listener 'click' pada document
    // TODO: Cek apakah target click adalah .btn-hapus menggunakan e.target.closest('.btn-hapus')
    // TODO: Jika ya, tampilkan confirm() dan hapus baris <tr> terkait jika disetujui
}

// Inisialisasi saat seluruh dokumen DOM selesai dimuat
document.addEventListener("DOMContentLoaded", function () {
    initNavToggle();
    initHapusConfirm();
});
