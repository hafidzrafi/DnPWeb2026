<?php
$page_title = "Daftar Buku";
require_once __DIR__ . '/../includes/header.php';

$daftar_buku = $_SESSION['buku'] ?? [];
?>

<div class="page-header">
    <h2>Daftar Buku</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Buku</a>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>Judul</th>
                <th>Pengarang</th>
                <th>Tahun</th>
                <th>ISBN</th>
                <th>Stok</th>
                <th>Kategori</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_buku)): ?>
                <tr>
                    <td colspan="6" style="text-align: center;">Belum ada data buku. Silakan tambah data baru.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_buku as $buku): ?>
                    <tr>
                        <td><?= htmlspecialchars($buku['judul'] ?? '') ?></td>
                        <td><?= htmlspecialchars($buku['pengarang'] ?? '') ?></td>
                        <td><?= htmlspecialchars($buku['tahun'] ?? '') ?></td>
                        <td><?= htmlspecialchars($buku['isbn'] ?? '') ?></td>
                        <td><?= htmlspecialchars($buku['stok'] ?? '') ?></td>
                        <td><?= htmlspecialchars($buku['kategori'] ?? '') ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
