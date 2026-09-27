/**
 * Jobsheet 06 - Fetch API & JSON (Buku)
 * SIMPUS-Mini Starter Skeleton
 */

// Mengambil & menampilkan Daftar Buku secara asinkron dari data/buku.json
async function muatDaftarBuku() {
    const tbody = document.querySelector(".table-responsive table tbody");
    const loading = document.getElementById("loading-indicator");
    if (!tbody) return;

    // TODO: Langkah 1 - Tampilkan indikator loading dan bersihkan isi tbody

    try {
        // TODO: Langkah 2 - Lakukan request HTTP GET menggunakan fetch('../data/buku.json')
        // TODO: Langkah 3 - Periksa response.ok, lemparkan Error jika response tidak sukses
        // TODO: Langkah 4 - Konversi response ke JSON dengan response.json()
        // TODO: Langkah 5 - Lakukan perulangan data buku dan render elemen <tr> ke dalam tbody
    } catch (err) {
        // TODO: Langkah 6 - Tangani kesalahan jika pengambilan data gagal dan tampilkan pesan error
    } finally {
        // TODO: Langkah 7 - Sembunyikan indikator loading
    }
}

document.addEventListener("DOMContentLoaded", muatDaftarBuku);
