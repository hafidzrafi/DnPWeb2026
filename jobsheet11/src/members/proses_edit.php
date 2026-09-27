<?php
/**
 * Jobsheet 09 - CRUD Penuh (Anggota)
 * Skeleton proses_edit.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

$id = $_POST['id'] ?? null;
// TODO: Langkah 1 - Ambil field no_anggota, nama, no_hp, alamat dari $_POST
// TODO: Langkah 2 - Validasi input data
// TODO: Langkah 3 - Jalankan query UPDATE menggunakan PDO prepared statement:
// UPDATE anggota SET no_anggota = :no_anggota, nama = :nama, no_hp = :no_hp, alamat = :alamat WHERE id = :id

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Data anggota berhasil diperbarui.'];
header('Location: list.php');
exit;
