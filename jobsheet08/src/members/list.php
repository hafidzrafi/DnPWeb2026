<?php
$page_title = "Daftar Anggota";
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
    <h2>Daftar Anggota (PostgreSQL)</h2>
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
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_anggota)): ?>
                <tr>
                    <td colspan="5" style="text-align: center;">Belum ada data anggota di database. Silakan tambah data baru.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_anggota as $anggota): ?>
                    <tr>
                        <td><?= htmlspecialchars($anggota['id'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['no_anggota'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['nama'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['alamat'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['no_hp'] ?? '') ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
