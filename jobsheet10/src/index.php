<?php
$page_title = "Dashboard Terproteksi";
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/header.php';
require_once __DIR__ . '/includes/koneksi.php';

try {
    $total_buku = (int) $pdo->query("SELECT COUNT(*) FROM buku")->fetchColumn();
    $total_anggota = (int) $pdo->query("SELECT COUNT(*) FROM anggota")->fetchColumn();
    $sedang_dipinjam = (int) $pdo->query("SELECT COUNT(*) FROM peminjaman WHERE status = 'dipinjam'")->fetchColumn();
} catch (PDOException $e) {
    $total_buku = 0;
    $total_anggota = 0;
    $sedang_dipinjam = 0;
}
?>

<div class="dashboard-header">
    <h1>Selamat Datang di Sistem Perpustakaan Mini</h1>
    <p>Aplikasi perpustakaan untuk mengelola data buku, anggota, dan transaksi peminjaman.</p>
</div>

<div class="stats-overview">
    <div class="stats-title">Ringkasan Sistem</div>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-label">Total Buku</div>
            <div class="stat-number"><?= $total_buku ?></div>
            <div class="stat-desc">Koleksi buku terdaftar</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Total Anggota</div>
            <div class="stat-number"><?= $total_anggota ?></div>
            <div class="stat-desc">Anggota perpustakaan aktif</div>
        </div>
        <div class="stat-card stat-highlight">
            <div class="stat-label">Sedang Dipinjam</div>
            <div class="stat-number"><?= $sedang_dipinjam ?></div>
            <div class="stat-desc">Buku beredar di peminjam</div>
        </div>
    </div>
</div>

<div class="card" style="margin-bottom: 24px;">
    <h3>Informasi Sesi Petugas</h3>
    <p>Status: <strong><?= isset($_SESSION['user']) ? 'Terautentikasi' : 'Tamu (Guest)' ?></strong></p>
    <?php if (isset($_SESSION['user'])): ?>
        <p>Login sebagai: <strong><?= htmlspecialchars($_SESSION['user']['username'] ?? '') ?></strong> (Role: <?= htmlspecialchars($_SESSION['user']['role'] ?? 'petugas') ?>)</p>
    <?php endif; ?>
</div>

<div class="card-grid">
    <div class="card">
        <h3>Modul Buku</h3>
        <p>Kelola koleksi buku, cek stok, tambah judul baru, dan perbarui data.</p>
        <a href="books/list.php" class="btn">Daftar Buku &rarr;</a>
    </div>
    <div class="card">
        <h3>Modul Anggota</h3>
        <p>Kelola data anggota peminjam, nomor identitas, dan kontak.</p>
        <a href="members/list.php" class="btn">Daftar Anggota &rarr;</a>
    </div>
    <div class="card">
        <h3>Transaksi Peminjaman</h3>
        <p>Catat peminjaman baru, kelola pengembalian, dan pantau riwayat sirkulasi.</p>
        <div style="display: flex; gap: 8px; margin-top: 12px;">
            <a href="peminjaman/tambah.php" class="btn btn-primary" style="font-size: 0.85rem; padding: 6px 12px;">+ Pinjam Buku</a>
            <a href="peminjaman/kembali.php" class="btn btn-secondary" style="font-size: 0.85rem; padding: 6px 12px;">Pengembalian &rarr;</a>
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>
