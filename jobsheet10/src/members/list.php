<?php
require_once __DIR__ . '/../includes/auth.php';
$page_title = "Daftar Anggota - CRUD";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

try {
    $stmt = $pdo->query("SELECT * FROM anggota ORDER BY id DESC");
    $daftar_anggota = $stmt->fetchAll();
} catch (PDOException $e) {
    $daftar_anggota = [];
    $error_msg = $e->getMessage();
}
?>

<div class="page-header">
    <h2>Daftar Anggota (CRUD Penuh)</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Anggota</a>
</div>

<?php if (isset($error_msg)): ?>
    <div class="flash flash-error">Database Error: <?= htmlspecialchars($error_msg) ?></div>
<?php endif; ?>

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
                        <td><?= htmlspecialchars($anggota['id'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['no_anggota'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['nama'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['alamat'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['no_hp'] ?? '') ?></td>
                        <td>
                            <a href="edit.php?id=<?= urlencode($anggota['id']) ?>" class="btn btn-secondary" style="padding: 4px 8px; font-size: 0.85rem;">Edit</a>
                            <form action="hapus.php" method="POST" style="display:inline;" onsubmit="return confirm('Yakin ingin menghapus anggota ini?');">
                                <input type="hidden" name="id" value="<?= htmlspecialchars($anggota['id']) ?>">
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
