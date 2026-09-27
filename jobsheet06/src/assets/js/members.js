/**
 * Jobsheet 06 - Fetch API & JSON (Members)
 * SIMPUS-Mini Starter Skeleton
 */

// Mengambil & menampilkan Daftar Anggota secara asinkron dari data/members.json
async function muatDaftarAnggota() {
    const tbody = document.querySelector(".table-responsive table tbody");
    const loading = document.getElementById("loading-indicator");
    if (!tbody) return;

    // TODO: Langkah 1 - Tampilkan indikator loading dan bersihkan isi tbody

    try {
        // TODO: Langkah 2 - Lakukan request HTTP GET menggunakan fetch('../data/members.json')
        // TODO: Langkah 3 - Validasi status response
        // TODO: Langkah 4 - Konversi data JSON
        // TODO: Langkah 5 - Render elemen <tr> untuk setiap anggota ke dalam tbody
    } catch (err) {
        // TODO: Langkah 6 - Tampilkan pesan error jika request gagal
    } finally {
        // TODO: Langkah 7 - Sembunyikan indikator loading
    }
}

document.addEventListener("DOMContentLoaded", muatDaftarAnggota);
