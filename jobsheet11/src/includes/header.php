<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once __DIR__ . '/helpers.php';
require_once __DIR__ . '/csrf.php';

$base_url = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/\\');
$current_folder = basename($base_url);
$root_path = in_array($current_folder, ['books', 'members', 'auth'], true) ? '..' : '.';
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
            <button id="nav-toggle-btn" class="nav-toggle" aria-label="Toggle Navigation">☰</button>
            <nav>
                <a href="<?= $root_path ?>/index.php">Dashboard</a>
                <a href="<?= $root_path ?>/books/list.php">Daftar Buku</a>
                <a href="<?= $root_path ?>/members/list.php">Daftar Anggota</a>
                <?php if (isset($_SESSION['user'])): ?>
                    <span class="user-greeting">Halo, <?= e($_SESSION['user']['username'] ?? 'User') ?></span>
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
            <div class="flash flash-<?= e($_SESSION['flash']['type']) ?>">
                <?= e($_SESSION['flash']['pesan']) ?>
            </div>
            <?php unset($_SESSION['flash']); ?>
        <?php endif; ?>
