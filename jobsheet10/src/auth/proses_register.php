<?php
/**
 * Jobsheet 10 - Autentikasi & Manajemen Sesi
 * Proses Registrasi Pengguna Baru
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: register.php');
    exit;
}

$nama = trim($_POST['nama'] ?? '');
$username = trim($_POST['username'] ?? '');
$password = $_POST['password'] ?? '';

$errors = [];
if ($username === '') {
    $errors[] = 'Username wajib diisi.';
}
if (strlen($password) < 6) {
    $errors[] = 'Password minimal 6 karakter.';
}
if ($nama === '') {
    $nama = $username;
}

if (!empty($errors)) {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => implode(' ', $errors)];
    header('Location: register.php');
    exit;
}

try {
    $cek = $pdo->prepare("SELECT id FROM users WHERE username = :username");
    $cek->execute([':username' => $username]);
    if ($cek->fetch()) {
        $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Username sudah digunakan. Silakan pilih username lain.'];
        header('Location: register.php');
        exit;
    }

    $hash = password_hash($password, PASSWORD_BCRYPT);
    $stmt = $pdo->prepare("INSERT INTO users (nama, username, password, role) VALUES (:nama, :username, :password, 'petugas')");
    $stmt->execute([
        ':nama' => $nama,
        ':username' => $username,
        ':password' => $hash,
    ]);

    $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Registrasi akun berhasil. Silakan login.'];
    header('Location: login.php');
    exit;
} catch (PDOException $e) {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Terjadi kesalahan sistem: ' . $e->getMessage()];
    header('Location: register.php');
    exit;
}
