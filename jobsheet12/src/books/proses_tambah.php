<?php
/**
 * Jobsheet 08 - Koneksi PostgreSQL (Buku)
 * Skeleton proses_tambah.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

// TODO: Langkah 1 - Ambil input $_POST dan bersihkan nilainya
// $judul = trim($_POST['judul'] ?? '');
// $pengarang = trim($_POST['pengarang'] ?? '');
// $tahun = (int) ($_POST['tahun'] ?? 0);
// $isbn = trim($_POST['isbn'] ?? '');
// $stok = (int) ($_POST['stok'] ?? 0);
// $kategori = trim($_POST['kategori'] ?? '');

// TODO: Langkah 2 - Validasi input data

// TODO: Langkah 3 - Siapkan Prepared Statement PDO untuk INSERT ke tabel buku:
// $sql = "INSERT INTO buku (judul, pengarang, tahun, isbn, stok, kategori) VALUES (:judul, :pengarang, :tahun, :isbn, :stok, :kategori)";
// $stmt = $pdo->prepare($sql);
// $stmt->execute([...]);

// TODO: Langkah 4 - Set flash message sukses
$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Data buku diproses.'];

// TODO: Langkah 5 - Redirect ke list.php
header('Location: list.php');
exit;
