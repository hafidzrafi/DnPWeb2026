<?php
$page_title = "Dashboard Terproteksi";
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/header.php';
require_once __DIR__ . '/includes/koneksi.php';
?>

<div class="dashboard-header">
    <h1>Dashboard SIMPUS-Mini</h1>
    <p>Jobsheet 10 - Autentikasi & Manajemen Sesi.</p>
</div>

<div class="card" style="margin-bottom: 24px;">
    <h3>Informasi Sesi Login</h3>
    <p>Status: <strong><?= isset($_SESSION['user']) ? 'Sudah Login' : 'Tamu (Guest)' ?></strong></p>
    <?php if (isset($_SESSION['user'])): ?>
        <p>Login sebagai: <strong><?= htmlspecialchars($_SESSION['user']['username'] ?? '') ?></strong> (Role: <?= htmlspecialchars($_SESSION['user']['role'] ?? '') ?>)</p>
    <?php endif; ?>
</div>

<div class="card-grid">
    <div class="card">
        <h3>Modul Buku</h3>
        <p>Kelola data buku perpustakaan.</p>
        <a href="books/list.php" class="btn">Buka Buku &rarr;</a>
    </div>
    <div class="card">
        <h3>Modul Anggota</h3>
        <p>Kelola data anggota perpustakaan.</p>
        <a href="members/list.php" class="btn">Buka Anggota &rarr;</a>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
