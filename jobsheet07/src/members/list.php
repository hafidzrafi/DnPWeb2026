<?php
$page_title = "Daftar Anggota";
require_once __DIR__ . '/../includes/header.php';

$daftar_anggota = $_SESSION['anggota'] ?? [];
?>

<div class="page-header">
    <h2>Daftar Anggota</h2>
    <a href="tambah.php" class="btn btn-primary">+ Tambah Anggota</a>
</div>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>No. Anggota</th>
                <th>Nama Lengkap</th>
                <th>Email</th>
                <th>No. Telepon</th>
                <th>Alamat</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($daftar_anggota)): ?>
                <tr>
                    <td colspan="5" style="text-align: center;">Belum ada data anggota. Silakan tambah data baru.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($daftar_anggota as $anggota): ?>
                    <tr>
                        <td><?= htmlspecialchars($anggota['nomor_anggota'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['nama'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['email'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['telepon'] ?? '') ?></td>
                        <td><?= htmlspecialchars($anggota['alamat'] ?? '') ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
