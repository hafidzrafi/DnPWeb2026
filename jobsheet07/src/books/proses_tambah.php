<?php
/**
 * Jobsheet 07 - PHP Dasar & Form Handling (Buku)
 * Skeleton proses_tambah.php
 */
session_start();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

// TODO: Langkah 1 - Ambil data dari $_POST dan lakukan sanitasi (trim)
// $judul = trim($_POST['judul'] ?? '');
// $pengarang = trim($_POST['pengarang'] ?? '');
// $tahun = $_POST['tahun'] ?? '';
// $isbn = trim($_POST['isbn'] ?? '');
// $stok = $_POST['stok'] ?? '';
// $kategori = trim($_POST['kategori'] ?? '');

// TODO: Langkah 2 - Lakukan validasi data di sisi server
// $errors = [];
// Cek jika field wajib kosong atau format tahun/stok tidak valid
// Jika ada error:
// $_SESSION['flash'] = ['type' => 'error', 'pesan' => implode(' ', $errors)];
// header('Location: tambah.php');
// exit;

// TODO: Langkah 3 - Simpan data buku ke dalam array $_SESSION['buku'][]
// if (!isset($_SESSION['buku'])) { $_SESSION['buku'] = []; }
// $_SESSION['buku'][] = [ ... ];

// TODO: Langkah 4 - Set flash message sukses
// $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Buku berhasil ditambahkan.'];

// TODO: Langkah 5 - Redirect ke halaman daftar buku (list.php)
header('Location: list.php');
exit;
