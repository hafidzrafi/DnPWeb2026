<?php
$page_title = "Dashboard";
require_once __DIR__ . '/includes/header.php';

$total_buku = count($_SESSION['buku'] ?? []);
$total_anggota = count($_SESSION['anggota'] ?? []);
?>

<div class="dashboard-header">
    <h1>Dashboard SIMPUS-Mini</h1>
    <p>Selamat datang di Sistem Informasi Perpustakaan (Jobsheet 07 - PHP Dasar & Form Handling).</p>
</div>

<div class="card-grid">
    <div class="card">
        <h3>Total Buku</h3>
        <p class="stat-number"><?= $total_buku ?></p>
        <a href="books/list.php" class="btn">Lihat Daftar Buku &rarr;</a>
    </div>
    <div class="card">
        <h3>Total Anggota</h3>
        <p class="stat-number"><?= $total_anggota ?></p>
        <a href="members/list.php" class="btn">Lihat Daftar Anggota &rarr;</a>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
