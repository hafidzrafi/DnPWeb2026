<?php
$page_title = "Riwayat Peminjaman";
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

// TODO: Query riwayat seluruh transaksi peminjaman (baik dipinjam maupun kembali)
// $sql = "SELECT p.*, b.judul, a.nama as nama_anggota FROM peminjaman p JOIN buku b ON p.buku_id = b.id JOIN anggota a ON p.anggota_id = a.id ORDER BY p.id DESC";
// $riwayat = $pdo->query($sql)->fetchAll();
$riwayat = [];
?>

<div class="page-header">
    <h2>Riwayat Transaksi Peminjaman</h2>
    <a href="tambah.php" class="btn btn-primary">+ Pinjam Buku Baru</a>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Judul Buku</th>
                <th>Nama Anggota</th>
                <th>Tgl Pinjam</th>
                <th>Tgl Kembali</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($riwayat)): ?>
                <tr>
                    <td colspan="6" style="text-align: center;">Belum ada riwayat transaksi peminjaman.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($riwayat as $r): ?>
                    <tr>
                        <td><?= htmlspecialchars($r['id']) ?></td>
                        <td><?= htmlspecialchars($r['judul']) ?></td>
                        <td><?= htmlspecialchars($r['nama_anggota']) ?></td>
                        <td><?= htmlspecialchars($r['tanggal_pinjam']) ?></td>
                        <td><?= htmlspecialchars($r['tanggal_kembali'] ?? '-') ?></td>
                        <td><?= htmlspecialchars($r['status']) ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
