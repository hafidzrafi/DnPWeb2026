<?php
require_once __DIR__ . '/../../includes/auth.php';
$page_title = "Daftar Buku - CRUD";
require_once __DIR__ . '/../../includes/header.php';
require_once __DIR__ . '/../../includes/koneksi.php';

try {
    $stmt = $pdo->query("SELECT * FROM buku ORDER BY id DESC");
    $daftar_buku = $stmt->fetchAll();
} catch (PDOException $e) {
    $daftar_buku = [];
    error_log('SIMPUS-Mini: ' . $e->getMessage());
    $error_msg = 'Data gagal dimuat. Periksa koneksi database.';
}
?>

<div class="page-header">
    <h2>Daftar Buku (CRUD Penuh)</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Buku</a>
</div>

<?php if (isset($error_msg)): ?>
    <div class="flash flash-error"><?= e($error_msg) ?></div>
<?php endif; ?>

<div class="table-toolbar">
    <div class="search-wrapper">
        <input type="text" id="search-input" placeholder="Ketik untuk mencari judul, pengarang, atau ISBN..." autocomplete="off">
    </div>
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
                        <td><?= e($buku['id'] ?? '') ?></td>
                        <td><?= e($buku['judul'] ?? '') ?></td>
                        <td><?= e($buku['pengarang'] ?? '') ?></td>
                        <td><?= e($buku['tahun'] ?? '') ?></td>
                        <td><?= e($buku['isbn'] ?? '') ?></td>
                        <td><?= e($buku['stok'] ?? '') ?></td>
                        <td><?= e($buku['kategori'] ?? '') ?></td>
                        <td>
                            <a href="edit.php?id=<?= urlencode($buku['id']) ?>" class="btn btn-secondary" style="padding: 4px 8px; font-size: 0.85rem;">Edit</a>
                            <form action="hapus.php" method="POST" style="display:inline;" onsubmit="return confirm('Yakin ingin menghapus buku ini?');">
                                <?= csrf_field() ?>
                                <input type="hidden" name="id" value="<?= e($buku['id']) ?>">
                                <button type="submit" class="btn" style="background:#dc2626; color:#fff; border:none; padding: 4px 8px; font-size: 0.85rem; cursor:pointer;">Hapus</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
