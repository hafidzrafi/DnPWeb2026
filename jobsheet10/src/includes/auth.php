<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user'])) {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Silakan login terlebih dahulu untuk mengakses sistem.'];
    $current_folder = basename(dirname($_SERVER['SCRIPT_NAME']));
    $root = ($current_folder === 'books' || $current_folder === 'members') ? '..' : '.';
    header("Location: $root/auth/login.php");
    exit;
}
