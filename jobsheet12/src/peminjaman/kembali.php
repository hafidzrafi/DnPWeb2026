<?php
$page_title = "Pengembalian Buku";
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

// TODO: Query daftar peminjaman dengan status 'dipinjam' beserta nama peminjam & judul buku (JOIN)
// $sql = "SELECT p.*, b.judul, a.nama as nama_anggota FROM peminjaman p JOIN buku b ON p.buku_id = b.id JOIN anggota a ON p.anggota_id = a.id WHERE p.status = 'dipinjam' ORDER BY p.tanggal_pinjam ASC";
// $daftar_pinjam = $pdo->query($sql)->fetchAll();
$daftar_pinjam = [];
?>

<div class="page-header">
    <h2>Buku Sedang Dipinjam</h2>
    <a href="tambah.php" class="btn btn-primary">+ Pinjam Buku Baru</a>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Judul Buku</th>
                <th>Nama Anggota</th>
                <th>Tanggal Pinjam</th>
                <th>Status</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_pinjam)): ?>
                <tr>
                    <td colspan="6" style="text-align: center;">Tidak ada buku yang sedang dipinjam.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_pinjam as $p): ?>
                    <tr>
                        <td><?= htmlspecialchars($p['id']) ?></td>
                        <td><?= htmlspecialchars($p['judul']) ?></td>
                        <td><?= htmlspecialchars($p['nama_anggota']) ?></td>
                        <td><?= htmlspecialchars($p['tanggal_pinjam']) ?></td>
                        <td><span class="badge badge-warning"><?= htmlspecialchars($p['status']) ?></span></td>
                        <td>
                            <form action="proses_kembali.php" method="POST" style="display:inline;">
                                <input type="hidden" name="peminjaman_id" value="<?= $p['id'] ?>">
                                <button type="submit" class="btn btn-sm btn-primary" onclick="return confirm('Proses pengembalian buku ini?')">Kembalikan</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
