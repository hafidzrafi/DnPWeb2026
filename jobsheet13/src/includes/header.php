<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once __DIR__ . '/helpers.php';
require_once __DIR__ . '/csrf.php';

$base_url = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/\\');
$current_folder = basename($base_url);
$root_path = in_array($current_folder, ['books', 'members', 'auth', 'peminjaman'], true) ? '..' : '.';
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= isset($page_title) ? e($page_title) . " - SIMPUS-Mini" : "SIMPUS-Mini" ?></title>
    <link rel="stylesheet" href="<?= $root_path ?>/assets/css/style.css">
    <script>
        if (localStorage.getItem('theme') === 'dark') {
            document.documentElement.classList.add('dark-theme');
        }
    </script>
</head>
<body>
    <header>
        <div class="header-container">
            <a href="<?= $root_path ?>/index.php" class="logo">SIMPUS-Mini</a>
            <button id="nav-toggle-btn" class="nav-toggle" aria-label="Buka menu navigasi">
                <svg viewBox="0 0 24 24" width="24" height="24" aria-hidden="true" focusable="false">
                    <path d="M3 6h18M3 12h18M3 18h18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </button>
            <nav>
                <a href="<?= $root_path ?>/index.php">Dashboard</a>
                <a href="<?= $root_path ?>/books/list.php">Daftar Buku</a>
                <a href="<?= $root_path ?>/members/list.php">Daftar Anggota</a>
                <?php if (isset($_SESSION['user'])): ?>
                    <a href="<?= $root_path ?>/peminjaman/tambah.php">Peminjaman Baru</a>
                    <a href="<?= $root_path ?>/peminjaman/kembali.php">Pengembalian</a>
                    <a href="<?= $root_path ?>/peminjaman/riwayat.php">Riwayat</a>
                    <span class="user-greeting">Halo, <?= e($_SESSION['user']['username'] ?? 'User') ?></span>
                    <a href="<?= $root_path ?>/auth/logout.php" class="btn-logout">Logout</a>
                <?php else: ?>
                    <a href="<?= $root_path ?>/auth/login.php">Login</a>
                    <a href="<?= $root_path ?>/auth/register.php">Register</a>
                <?php endif; ?>
                <button id="theme-toggle-btn" class="theme-toggle" type="button" aria-label="Ubah tema terang atau gelap" title="Ubah tema">
                    <svg class="icon-moon" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true" focusable="false">
                        <path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z" fill="currentColor"/>
                    </svg>
                    <svg class="icon-sun" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true" focusable="false">
                        <circle cx="12" cy="12" r="4.5" fill="currentColor"/>
                        <path d="M12 2v2.5M12 19.5V22M2 12h2.5M19.5 12H22M4.9 4.9l1.8 1.8M17.3 17.3l1.8 1.8M19.1 4.9l-1.8 1.8M6.7 17.3l-1.8 1.8" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                </button>
            </nav>
        </div>
    </header>

    <main class="main-content">
        <?php if (!empty($_SESSION['flash'])): ?>
            <div class="flash flash-<?= e($_SESSION['flash']['type']) ?>">
                <?= e($_SESSION['flash']['pesan']) ?>
            </div>
            <?php unset($_SESSION['flash']); ?>
        <?php endif; ?>
