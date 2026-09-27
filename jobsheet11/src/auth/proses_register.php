<?php
/**
 * Jobsheet 10 - Autentikasi & Manajemen Sesi
 * Skeleton proses_register.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: register.php');
    exit;
}

$username = trim($_POST['username'] ?? '');
$password = $_POST['password'] ?? '';

// TODO: Langkah 1 - Validasi input username dan password

// TODO: Langkah 2 - Cek apakah username sudah digunakan di database

// TODO: Langkah 3 - Hash password menggunakan algoritma BCRYPT:
// $hash = password_hash($password, PASSWORD_BCRYPT);

// TODO: Langkah 4 - Simpan user baru ke tabel users:
// $stmt = $pdo->prepare("INSERT INTO users (username, password, role) VALUES (:username, :password, 'petugas')");
// $stmt->execute([':username' => $username, ':password' => $hash]);

$_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Registrasi akun berhasil. Silakan login.'];
header('Location: login.php');
exit;
