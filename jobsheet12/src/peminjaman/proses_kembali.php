<?php
/**
 * Jobsheet 12 - Integrasi Modul Peminjaman
 * Skeleton proses_kembali.php
 */
session_start();
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: kembali.php');
    exit;
}

$peminjaman_id = $_POST['peminjaman_id'] ?? null;

// TODO: Langkah 1 - Pastikan data peminjaman ada dan statusnya masih 'dipinjam'

// TODO: Langkah 2 - Gunakan Transaction (PDO beginTransaction, commit, rollBack):
// a. UPDATE peminjaman SET status = 'kembali', tanggal_kembali = CURRENT_DATE WHERE id = :id
// b. UPDATE buku SET stok = stok + 1 WHERE id = :buku_id

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Buku berhasil dikembalikan dan stok diperbarui.'];
header('Location: kembali.php');
exit;
