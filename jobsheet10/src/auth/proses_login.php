<?php
/**
 * Jobsheet 10 - Autentikasi & Manajemen Sesi
 * Skeleton proses_login.php
 */
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: login.php');
    exit;
}

$username = trim($_POST['username'] ?? '');
$password = $_POST['password'] ?? '';

// TODO: Langkah 1 - Query pengguna berdasarkan username dari tabel users
// $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
// $stmt->execute([':username' => $username]);
// $user = $stmt->fetch();

// TODO: Langkah 2 - Verifikasi password menggunakan password_verify($password, $user['password'])
// if ($user && password_verify($password, $user['password'])) {
//     $_SESSION['user'] = [
//         'id' => $user['id'],
//         'username' => $user['username'],
//         'role' => $user['role'] ?? 'petugas'
//     ];
//     $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Login berhasil. Selamat datang!'];
//     header('Location: ../index.php');
//     exit;
// }

$_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Username atau password salah.'];
header('Location: login.php');
exit;
