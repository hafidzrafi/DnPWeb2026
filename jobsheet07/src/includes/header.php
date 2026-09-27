<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
// Base path helper
$base_url = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/\\');
// If inside subfolder like books or members, adjust base path
if (basename($base_url) === 'books' || basename($base_url) === 'members') {
    $root_path = '..';
} else {
    $root_path = '.';
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= isset($page_title) ? htmlspecialchars($page_title) . " - SIMPUS-Mini" : "SIMPUS-Mini" ?></title>
    <link rel="stylesheet" href="<?= $root_path ?>/assets/css/style.css">
</head>
<body>
    <header>
        <div class="header-container">
            <a href="<?= $root_path ?>/index.php" class="logo">SIMPUS-Mini</a>
            <button id="nav-toggle-btn" class="nav-toggle" aria-label="Toggle Navigation">☰</button>
            <nav>
                <a href="<?= $root_path ?>/index.php">Dashboard</a>
                <a href="<?= $root_path ?>/books/list.php">Daftar Buku</a>
                <a href="<?= $root_path ?>/books/tambah.php">Tambah Buku</a>
                <a href="<?= $root_path ?>/members/list.php">Daftar Anggota</a>
                <a href="<?= $root_path ?>/members/tambah.php">Tambah Anggota</a>
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
