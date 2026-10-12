<?php
require_once __DIR__ . '/../includes/auth.php';
$page_title = "Pengembalian Buku";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

try {
    $stmt = $pdo->query(
        "SELECT p.id, p.buku_id, p.tanggal_pinjam, p.status, b.judul, a.nama, a.no_anggota
         FROM peminjaman p
         JOIN buku b ON p.buku_id = b.id
         JOIN anggota a ON p.anggota_id = a.id
         WHERE p.status = 'dipinjam'
         ORDER BY p.id DESC"
    );
    $daftar_pinjam = $stmt->fetchAll();
} catch (PDOException $e) {
    $daftar_pinjam = [];
    $error_msg = $e->getMessage();
}
?>

<div class="page-header">
    <div>
        <h2>Daftar Peminjaman Aktif</h2>
        <p class="subtitle">Buku yang sedang dipinjam dan belum dikembalikan ke perpustakaan.</p>
    </div>
    <div style="display: flex; gap: 8px;">
        <a href="tambah.php" class="btn btn-primary">+ Pinjam Buku Baru</a>
        <a href="riwayat.php" class="btn btn-secondary">Lihat Riwayat</a>
    </div>
</div>

<?php if (isset($error_msg)): ?>
    <div class="flash flash-error">Database Error: <?= htmlspecialchars($error_msg) ?></div>
<?php endif; ?>

<div class="table-toolbar">
    <div class="search-wrapper">
        <input type="text" id="search-input" placeholder="Ketik untuk mencari anggota atau judul buku..." autocomplete="off">
    </div>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nama Anggota</th>
                <th>Judul Buku</th>
                <th>Tgl Pinjam</th>
                <th>Status</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_pinjam)): ?>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 2rem;">Tidak ada peminjaman aktif saat ini. Semua buku telah dikembalikan.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_pinjam as $item): ?>
                    <tr>
                        <td>#<?= htmlspecialchars($item['id']) ?></td>
                        <td>
                            <strong><?= htmlspecialchars($item['nama']) ?></strong>
                            <div style="font-size: 0.8rem; color: #64748b;"><?= htmlspecialchars($item['no_anggota']) ?></div>
                        </td>
                        <td><?= htmlspecialchars($item['judul']) ?></td>
                        <td><?= htmlspecialchars($item['tanggal_pinjam']) ?></td>
                        <td><span class="badge badge-warning">Dipinjam</span></td>
                        <td>
                            <form action="proses_kembali.php" method="POST" class="form-kembali" style="display:inline;" onsubmit="return confirm('Proses pengembalian buku \'<?= htmlspecialchars(addslashes($item['judul'])) ?>\' oleh <?= htmlspecialchars(addslashes($item['nama'])) ?>?');">
                                <input type="hidden" name="id" value="<?= htmlspecialchars($item['id']) ?>">
                                <button type="submit" class="btn btn-success" style="padding: 4px 10px; font-size: 0.85rem;">Kembalikan</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
