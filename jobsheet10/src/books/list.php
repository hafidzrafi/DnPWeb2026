<?php
require_once __DIR__ . '/../includes/auth.php';
$page_title = "Daftar Buku - CRUD";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

try {
    $stmt = $pdo->query("SELECT * FROM buku ORDER BY id DESC");
    $daftar_buku = $stmt->fetchAll();
} catch (PDOException $e) {
    $daftar_buku = [];
    $error_msg = $e->getMessage();
}
?>

<div class="page-header">
    <h2>Daftar Buku (CRUD Penuh)</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Buku</a>
</div>

<?php if (isset($error_msg)): ?>
    <div class="flash flash-error">Database Error: <?= htmlspecialchars($error_msg) ?></div>
<?php endif; ?>

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
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_buku)): ?>
                <tr>
                    <td colspan="8" style="text-align: center;">Belum ada data buku di database.</td>
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
                        <td>
                            <a href="edit.php?id=<?= urlencode($buku['id']) ?>" class="btn btn-secondary" style="padding: 4px 8px; font-size: 0.85rem;">Edit</a>
                            <form action="hapus.php" method="POST" style="display:inline;" onsubmit="return confirm('Yakin ingin menghapus buku ini?');">
                                <input type="hidden" name="id" value="<?= htmlspecialchars($buku['id']) ?>">
                                <button type="submit" class="btn" style="background:#dc2626; color:#fff; border:none; padding: 4px 8px; font-size: 0.85rem; cursor:pointer;">Hapus</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
