<?php
require_once __DIR__ . '/../../includes/auth.php';
$page_title = "Daftar Anggota - CRUD";
require_once __DIR__ . '/../../includes/header.php';
require_once __DIR__ . '/../../includes/koneksi.php';

try {
    $stmt = $pdo->query("SELECT * FROM anggota ORDER BY id DESC");
    $daftar_anggota = $stmt->fetchAll();
} catch (PDOException $e) {
    $daftar_anggota = [];
    error_log('SIMPUS-Mini: ' . $e->getMessage());
    $error_msg = 'Data gagal dimuat. Periksa koneksi database.';
}
?>

<div class="page-header">
    <h2>Daftar Anggota (CRUD Penuh)</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Anggota</a>
</div>

<?php if (isset($error_msg)): ?>
    <div class="flash flash-error"><?= e($error_msg) ?></div>
<?php endif; ?>

<div class="table-toolbar">
    <div class="search-wrapper">
        <input type="text" id="search-input" placeholder="Ketik untuk mencari nama, no anggota, atau no hp..." autocomplete="off">
    </div>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Anggota</th>
                <th>Nama</th>
                <th>Alamat</th>
                <th>No. HP</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_anggota)): ?>
                <tr>
                    <td colspan="6" style="text-align: center;">Belum ada data anggota di database.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_anggota as $anggota): ?>
                    <tr>
                        <td><?= e($anggota['id'] ?? '') ?></td>
                        <td><?= e($anggota['no_anggota'] ?? '') ?></td>
                        <td><?= e($anggota['nama'] ?? '') ?></td>
                        <td><?= e($anggota['alamat'] ?? '') ?></td>
                        <td><?= e($anggota['no_hp'] ?? '') ?></td>
                        <td>
                            <a href="edit.php?id=<?= urlencode($anggota['id']) ?>" class="btn btn-secondary" style="padding: 4px 8px; font-size: 0.85rem;">Edit</a>
                            <form action="hapus.php" method="POST" style="display:inline;" onsubmit="return confirm('Yakin ingin menghapus anggota ini?');">
                                <?= csrf_field() ?>
                                <input type="hidden" name="id" value="<?= e($anggota['id']) ?>">
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
