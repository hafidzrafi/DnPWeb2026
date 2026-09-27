<?php
$page_title = "Daftar Buku";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

// TODO: Query data buku dari PostgreSQL menggunakan PDO
// $stmt = $pdo->query("SELECT * FROM buku ORDER BY id DESC");
// $daftar_buku = $stmt->fetchAll();
$daftar_buku = [];
?>

<div class="page-header">
    <h2>Daftar Buku (PostgreSQL)</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Buku</a>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>ID</th>
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
                    <td colspan="7" style="text-align: center;">Belum ada data buku di database. Silakan jalankan DDL dan tambah data.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_buku as $buku): ?>
                    <tr>
                        <td><?= htmlspecialchars($buku['id'] ?? '') ?></td>
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
