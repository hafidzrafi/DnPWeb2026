<?php
/**
 * Jobsheet 09 - CRUD Penuh (Buku)
 * Skeleton proses_edit.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

$id = $_POST['id'] ?? null;
// TODO: Langkah 1 - Ambil field judul, pengarang, tahun, isbn, stok, kategori dari $_POST
// TODO: Langkah 2 - Validasi input data
// TODO: Langkah 3 - Jalankan query UPDATE menggunakan PDO prepared statement:
// UPDATE buku SET judul = :judul, pengarang = :pengarang, tahun = :tahun, isbn = :isbn, stok = :stok, kategori = :kategori WHERE id = :id

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Data buku berhasil diperbarui.'];
header('Location: list.php');
exit;
