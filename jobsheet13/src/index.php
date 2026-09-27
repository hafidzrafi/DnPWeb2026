<?php
$page_title = "Dashboard SIMPUS-Mini";
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/header.php';
require_once __DIR__ . '/includes/koneksi.php';
?>

<div class="dashboard-header">
    <h1>Dashboard SIMPUS-Mini</h1>
    <p>Jobsheet 12 - Integrasi Modul Peminjaman & Pengembalian.</p>
</div>

<div class="card-grid">
    <div class="card">
        <h3>Peminjaman Buku</h3>
        <p>Catat transaksi peminjaman buku oleh anggota perpustakaan.</p>
        <a href="peminjaman/tambah.php" class="btn">Pinjam Buku &rarr;</a>
    </div>
    <div class="card">
        <h3>Pengembalian Buku</h3>
        <p>Kelola dan konfirmasi pengembalian buku yang sedang dipinjam.</p>
        <a href="peminjaman/kembali.php" class="btn">Pengembalian &rarr;</a>
    </div>
    <div class="card">
        <h3>Riwayat Transaksi</h3>
        <p>Lihat log seluruh riwayat peminjaman dan pengembalian.</p>
        <a href="peminjaman/riwayat.php" class="btn">Lihat Riwayat &rarr;</a>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
