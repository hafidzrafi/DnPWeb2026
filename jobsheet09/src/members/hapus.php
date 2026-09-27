<?php
/**
 * Jobsheet 09 - CRUD Penuh (Anggota)
 * Skeleton hapus.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

$id = $_GET['id'] ?? null;

// TODO: Langkah 1 - Cek jika ID tersedia
// TODO: Langkah 2 - Jalankan query DELETE dari tabel anggota menggunakan PDO prepared statement:
// DELETE FROM anggota WHERE id = :id

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Data anggota berhasil dihapus.'];
header('Location: list.php');
exit;
