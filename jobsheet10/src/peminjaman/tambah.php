<?php
require_once __DIR__ . '/../includes/auth.php';
$page_title = "Peminjaman Buku Baru";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

$daftar_anggota = $pdo->query("SELECT id, nama, no_anggota FROM anggota ORDER BY nama ASC")->fetchAll();
$daftar_buku = $pdo->query("SELECT id, judul, stok FROM buku WHERE stok > 0 ORDER BY judul ASC")->fetchAll();
?>

<div class="page-header">
    <h2>Peminjaman Buku Baru</h2>
    <a href="kembali.php" class="btn btn-secondary">&larr; Daftar Peminjaman</a>
</div>

<div class="form-container">
    <?php if (empty($daftar_anggota)): ?>
        <div class="flash flash-error">Belum ada data anggota. Silakan tambah anggota terlebih dahulu.</div>
    <?php elseif (empty($daftar_buku)): ?>
        <div class="flash flash-error">Tidak ada buku dengan stok tersedia saat ini.</div>
    <?php else: ?>
        <form id="form-tambah" action="proses_tambah.php" method="POST">
            <div class="form-group">
                <label for="anggota_id">Nama Anggota *</label>
                <select id="anggota_id" name="anggota_id" required>
                    <option value="">-- Pilih Anggota Peminjam --</option>
                    <?php foreach ($daftar_anggota as $anggota): ?>
                        <option value="<?= htmlspecialchars($anggota['id']) ?>">
                            <?= htmlspecialchars($anggota['nama']) ?> (<?= htmlspecialchars($anggota['no_anggota']) ?>)
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label for="buku_id">Buku (Hanya Stok Tersedia) *</label>
                <select id="buku_id" name="buku_id" required>
                    <option value="">-- Pilih Buku yang Dipinjam --</option>
                    <?php foreach ($daftar_buku as $buku): ?>
                        <option value="<?= htmlspecialchars($buku['id']) ?>">
                            <?= htmlspecialchars($buku['judul']) ?> (Sisa Stok: <?= htmlspecialchars($buku['stok']) ?>)
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label for="tanggal_pinjam">Tanggal Pinjam</label>
                <input type="date" id="tanggal_pinjam" name="tanggal_pinjam" value="<?= date('Y-m-d') ?>" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Simpan Transaksi Peminjaman</button>
                <a href="kembali.php" class="btn btn-secondary">Batal</a>
            </div>
        </form>
    <?php endif; ?>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
