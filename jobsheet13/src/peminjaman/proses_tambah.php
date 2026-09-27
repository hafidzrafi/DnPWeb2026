<?php
/**
 * Jobsheet 12 - Integrasi Modul Peminjaman
 * Skeleton proses_tambah.php
 */
session_start();
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/koneksi.php';
require_once __DIR__ . '/../includes/csrf.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: tambah.php');
    exit;
}

// TODO: Langkah 1 - Verifikasi token CSRF: csrf_verify()

// TODO: Langkah 2 - Ambil buku_id, anggota_id, tanggal_pinjam dari $_POST

// TODO: Langkah 3 - Gunakan Transaction (PDO beginTransaction, commit, rollBack):
// a. Pastikan stok buku > 0
// b. INSERT ke tabel peminjaman (buku_id, anggota_id, tanggal_pinjam, status = 'dipinjam')
// c. UPDATE buku SET stok = stok - 1 WHERE id = :buku_id

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Peminjaman berhasil dicatat.'];
header('Location: kembali.php');
exit;
