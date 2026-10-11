<?php
/**
 * Jobsheet 10 - Autentikasi & Manajemen Sesi
 * Proses Login Pengguna
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: login.php');
    exit;
}

$username = trim($_POST['username'] ?? '');
$password = $_POST['password'] ?? '';

if ($username === '' || $password === '') {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Username dan password wajib diisi.'];
    header('Location: login.php');
    exit;
}

try {
    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
    $stmt->execute([':username' => $username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        // Mencegah Session Fixation
        session_regenerate_id(true);

        $_SESSION['user'] = [
            'id' => $user['id'],
            'nama' => $user['nama'],
            'username' => $user['username'],
            'role' => $user['role'] ?? 'petugas',
        ];
        $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Login berhasil! Selamat datang, ' . htmlspecialchars($user['nama']) . '.'];
        header('Location: ../index.php');
        exit;
    }

    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Username atau password salah.'];
    header('Location: login.php');
    exit;
} catch (PDOException $e) {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Terjadi kesalahan sistem: ' . $e->getMessage()];
    header('Location: login.php');
    exit;
}
