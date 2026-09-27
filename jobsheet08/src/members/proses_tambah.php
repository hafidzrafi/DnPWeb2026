<?php
/**
 * Jobsheet 08 - Koneksi PostgreSQL (Anggota)
 * Skeleton proses_tambah.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

// TODO: Langkah 1 - Ambil input $_POST (no_anggota, nama, no_hp, alamat)
// $no_anggota = trim($_POST['no_anggota'] ?? '');
// $nama = trim($_POST['nama'] ?? '');
// $no_hp = trim($_POST['no_hp'] ?? '');
// $alamat = trim($_POST['alamat'] ?? '');

// TODO: Langkah 2 - Validasi input data

// TODO: Langkah 3 - Prepared statement INSERT ke PostgreSQL
// $sql = "INSERT INTO anggota (no_anggota, nama, no_hp, alamat) VALUES (:no_anggota, :nama, :no_hp, :alamat)";
// $stmt = $pdo->prepare($sql);
// $stmt->execute([...]);

// TODO: Langkah 4 - Set flash message
$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Data anggota diproses.'];

// TODO: Langkah 5 - Redirect ke list.php
header('Location: list.php');
exit;
