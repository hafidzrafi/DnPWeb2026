<?php
/**
 * Jobsheet 07 - PHP Dasar & Form Handling (Anggota)
 * Skeleton proses_tambah.php
 */
session_start();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

// TODO: Langkah 1 - Ambil data anggota dari $_POST (nomor_anggota, nama, email, telepon, alamat)
// $nomor_anggota = trim($_POST['nomor_anggota'] ?? '');
// $nama = trim($_POST['nama'] ?? '');
// $email = trim($_POST['email'] ?? '');
// $telepon = trim($_POST['telepon'] ?? '');
// $alamat = trim($_POST['alamat'] ?? '');

// TODO: Langkah 2 - Lakukan validasi server-side
// Cek jika nomor_anggota, nama, atau email kosong, atau format email tidak valid (filter_var)
// Jika ada error:
// $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Mohon isi semua field wajib dengan benar.'];
// header('Location: tambah.php');
// exit;

// TODO: Langkah 3 - Simpan data anggota ke dalam array $_SESSION['anggota'][]
// if (!isset($_SESSION['anggota'])) { $_SESSION['anggota'] = []; }
// $_SESSION['anggota'][] = [ ... ];

// TODO: Langkah 4 - Set flash message sukses
// $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Anggota berhasil ditambahkan.'];

// TODO: Langkah 5 - Redirect ke halaman daftar anggota (list.php)
header('Location: list.php');
exit;
