<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$base_url = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/\\');
$current_folder = basename($base_url);
$root_path = ($current_folder === 'books' || $current_folder === 'members' || $current_folder === 'auth' || $current_folder === 'peminjaman') ? '..' : '.';
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= isset($page_title) ? htmlspecialchars($page_title) . " - SIMPUS-Mini" : "SIMPUS-Mini" ?></title>
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
            <button id="nav-toggle-btn" class="nav-toggle" aria-label="Toggle Navigation">☰</button>
            <nav>
                <a href="<?= $root_path ?>/index.php">Dashboard</a>
                <a href="<?= $root_path ?>/books/list.php">Daftar Buku</a>
                <a href="<?= $root_path ?>/members/list.php">Daftar Anggota</a>
                <?php if (isset($_SESSION['user'])): ?>
                    <a href="<?= $root_path ?>/peminjaman/kembali.php">Peminjaman</a>
                    <a href="<?= $root_path ?>/peminjaman/riwayat.php">Riwayat</a>
                    <span class="user-greeting">Halo, <?= htmlspecialchars($_SESSION['user']['username'] ?? 'User') ?></span>
                    <a href="<?= $root_path ?>/auth/logout.php" class="btn-logout">Logout</a>
                <?php else: ?>
                    <a href="<?= $root_path ?>/auth/login.php">Login</a>
                    <a href="<?= $root_path ?>/auth/register.php">Register</a>
                <?php endif; ?>
                <button id="theme-toggle-btn" class="theme-toggle" type="button" aria-label="Ubah Tema" title="Ubah Tema">🌙</button>
            </nav>
        </div>
    </header>

    <main class="main-content">
        <?php if (!empty($_SESSION['flash'])): ?>
            <div class="flash flash-<?= htmlspecialchars($_SESSION['flash']['type']) ?>">
                <?= htmlspecialchars($_SESSION['flash']['pesan']) ?>
            </div>
            <?php unset($_SESSION['flash']); ?>
        <?php endif; ?>
