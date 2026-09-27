<?php
/**
 * Jobsheet 10 - Autentikasi & Manajemen Sesi
 * Middleware/Guard Session Check
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// TODO: Langkah 1 - Cek apakah key 'user' atau 'user_id' ada di $_SESSION
// Jika tidak ada, pengguna belum login.
// Redirect ke halaman login:
// if (!isset($_SESSION['user'])) {
//     $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Silakan login terlebih dahulu.'];
//     $root = (basename(dirname($_SERVER['SCRIPT_NAME'])) === 'books' || basename(dirname($_SERVER['SCRIPT_NAME'])) === 'members') ? '..' : '.';
//     header("Location: $root/auth/login.php");
//     exit;
// }
