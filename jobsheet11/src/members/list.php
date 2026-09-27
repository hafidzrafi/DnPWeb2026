<?php
$page_title = "Daftar Anggota - CRUD Penuh";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

// TODO: Query data anggota dari PostgreSQL menggunakan PDO
// $stmt = $pdo->query("SELECT * FROM anggota ORDER BY id DESC");
// $daftar_anggota = $stmt->fetchAll();
$daftar_anggota = [];
?>

<div class="page-header">
    <h2>Daftar Anggota (CRUD Penuh)</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Anggota</a>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Anggota</th>
                <th>Nama Lengkap</th>
                <th>No. HP</th>
                <th>Alamat</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_anggota)): ?>
                <tr>
                    <td colspan="6" style="text-align: center;">Belum ada data anggota. Silakan tambah data baru.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_anggota as $anggota): ?>
                    <tr>
                        <td><?= htmlspecialchars($anggota['id'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['no_anggota'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['nama'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['no_hp'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['alamat'] ?? '') ?></td>
                        <td>
                            <a href="edit.php?id=<?= $anggota['id'] ?>" class="btn btn-sm">Edit</a>
                            <a href="hapus.php?id=<?= $anggota['id'] ?>" class="btn btn-sm btn-danger btn-hapus" onclick="return confirm('Yakin hapus data ini?')">Hapus</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
