<?php
/**
 * Jobsheet 09 - CRUD Penuh (Buku)
 * Skeleton hapus.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

$id = $_GET['id'] ?? null;

// TODO: Langkah 1 - Cek jika ID tersedia
// TODO: Langkah 2 - Jalankan query DELETE dari tabel buku menggunakan PDO prepared statement:
// DELETE FROM buku WHERE id = :id

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Data buku berhasil dihapus.'];
header('Location: list.php');
exit;
