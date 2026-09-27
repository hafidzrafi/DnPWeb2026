<?php
$page_title = "Dashboard";
require_once __DIR__ . '/includes/header.php';
require_once __DIR__ . '/includes/koneksi.php';

$status_db = isset($pdo) ? "Terhubung ke PostgreSQL" : "Belum Terhubung (" . ($db_error ?? "Cek koneksi.php") . ")";
?>

<div class="dashboard-header">
    <h1>Dashboard SIMPUS-Mini</h1>
    <p>Jobsheet 08 - Koneksi PostgreSQL & Setup Database.</p>
</div>

<div class="card" style="margin-bottom: 24px;">
    <h3>Status Koneksi Database:</h3>
    <p style="font-weight: 600; color: <?= isset($pdo) ? '#059669' : '#dc2626' ?>;">
        <?= htmlspecialchars($status_db) ?>
    </p>
</div>

<div class="card-grid">
    <div class="card">
        <h3>Modul Buku</h3>
        <p>Kelola data buku yang tersimpan di tabel database PostgreSQL.</p>
        <a href="books/list.php" class="btn">Buka Buku &rarr;</a>
    </div>
    <div class="card">
        <h3>Modul Anggota</h3>
        <p>Kelola data anggota perpustakaan yang tersimpan di PostgreSQL.</p>
        <a href="members/list.php" class="btn">Buka Anggota &rarr;</a>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
