<?php
$page_title = "Peminjaman Buku";
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';
require_once __DIR__ . '/../includes/csrf.php';

// TODO: Query daftar buku yang stoknya > 0
// $buku_tersedia = $pdo->query("SELECT id, judul, stok FROM buku WHERE stok > 0 ORDER BY judul")->fetchAll();
$buku_tersedia = [];

// TODO: Query daftar anggota aktif
// $anggota_list = $pdo->query("SELECT id, no_anggota, nama FROM anggota ORDER BY nama")->fetchAll();
$anggota_list = [];
?>

<div class="page-header">
    <h2>Transaksi Peminjaman Buku</h2>
</div>

<div class="form-container">
    <form action="proses_tambah.php" method="POST">
        <?= csrf_field() ?>

        <div class="form-group">
            <label for="buku_id">Pilih Buku *</label>
            <select name="buku_id" id="buku_id" required>
                <option value="">-- Pilih Buku Tersedia --</option>
                <?php foreach ($buku_tersedia as $b): ?>
                    <option value="<?= $b['id'] ?>"><?= htmlspecialchars($b['judul']) ?> (Stok: <?= $b['stok'] ?>)</option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="form-group">
            <label for="anggota_id">Pilih Anggota Peminjam *</label>
            <select name="anggota_id" id="anggota_id" required>
                <option value="">-- Pilih Anggota --</option>
                <?php foreach ($anggota_list as $a): ?>
                    <option value="<?= $a['id'] ?>"><?= htmlspecialchars($a['nama']) ?> (<?= htmlspecialchars($a['no_anggota']) ?>)</option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="form-group">
            <label for="tanggal_pinjam">Tanggal Pinjam *</label>
            <input type="date" id="tanggal_pinjam" name="tanggal_pinjam" required value="<?= date('Y-m-d') ?>">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Proses Peminjaman</button>
            <a href="riwayat.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
