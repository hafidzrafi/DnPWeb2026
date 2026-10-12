<?php
require_once __DIR__ . '/../includes/auth.php';
$page_title = "Riwayat Peminjaman";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

$anggota_id = $_GET['anggota_id'] ?? '';
$daftar_anggota = $pdo->query("SELECT id, nama FROM anggota ORDER BY nama ASC")->fetchAll();

$query_sql = "SELECT p.id, p.tanggal_pinjam, p.tanggal_kembali, p.status, b.judul, a.nama, a.no_anggota
              FROM peminjaman p
              JOIN buku b ON b.id = p.buku_id
              JOIN anggota a ON a.id = p.anggota_id";

if ($anggota_id !== '') {
    $stmt = $pdo->prepare($query_sql . " WHERE p.anggota_id = :id ORDER BY p.id DESC");
    $stmt->execute([':id' => $anggota_id]);
} else {
    $stmt = $pdo->query($query_sql . " ORDER BY p.id DESC");
}
$daftar_riwayat = $stmt->fetchAll();
?>

<div class="page-header">
    <div>
        <h2>Riwayat Seluruh Transaksi</h2>
        <p class="subtitle">Catatan historis seluruh peminjaman dan pengembalian buku.</p>
    </div>
    <div style="display: flex; gap: 8px;">
        <a href="kembali.php" class="btn btn-secondary">Peminjaman Aktif</a>
        <a href="tambah.php" class="btn btn-primary">+ Pinjam Baru</a>
    </div>
</div>

<div class="table-toolbar" style="display: flex; flex-wrap: wrap; gap: 12px; align-items: center; justify-content: space-between; margin-bottom: 1rem;">
    <form method="GET" action="riwayat.php" style="display: flex; gap: 8px; align-items: center;">
        <select name="anggota_id" onchange="this.form.submit()" style="padding: 7px 12px; border-radius: 6px; border: 1px solid #cbd5e1; font-size: 0.9rem;">
            <option value="">-- Semua Anggota --</option>
            <?php foreach ($daftar_anggota as $agt): ?>
                <option value="<?= htmlspecialchars($agt['id']) ?>" <?= (string)$anggota_id === (string)$agt['id'] ? 'selected' : '' ?>>
                    <?= htmlspecialchars($agt['nama']) ?>
                </option>
            <?php endforeach; ?>
        </select>
        <?php if ($anggota_id !== ''): ?>
            <a href="riwayat.php" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.85rem;">Reset Filter</a>
        <?php endif; ?>
    </form>

    <div class="search-wrapper" style="flex: 1; max-width: 320px;">
        <input type="text" id="search-input" placeholder="Ketik untuk filter cepat..." autocomplete="off">
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
                <th>Tgl Kembali</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_riwayat)): ?>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 2rem;">Belum ada riwayat transaksi peminjaman.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_riwayat as $r): ?>
                    <tr>
                        <td>#<?= htmlspecialchars($r['id']) ?></td>
                        <td>
                            <strong><?= htmlspecialchars($r['nama']) ?></strong>
                            <div style="font-size: 0.8rem; color: #64748b;"><?= htmlspecialchars($r['no_anggota']) ?></div>
                        </td>
                        <td><?= htmlspecialchars($r['judul']) ?></td>
                        <td><?= htmlspecialchars($r['tanggal_pinjam']) ?></td>
                        <td><?= $r['tanggal_kembali'] ? htmlspecialchars($r['tanggal_kembali']) : '<span style="color:#94a3b8;">-</span>' ?></td>
                        <td>
                            <?php if ($r['status'] === 'dipinjam'): ?>
                                <span class="badge badge-warning">Dipinjam</span>
                            <?php else: ?>
                                <span class="badge badge-success">Dikembalikan</span>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
