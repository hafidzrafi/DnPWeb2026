<?php
require_once __DIR__ . '/../includes/auth.php';
$page_title = "Edit Anggota";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

$id = $_GET['id'] ?? null;
if (!$id) {
    header('Location: list.php');
    exit;
}

$stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = :id");
$stmt->execute([':id' => $id]);
$anggota = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$anggota) {
    header('Location: list.php');
    exit;
}
?>

<div class="page-header">
    <h2>Edit Data Anggota</h2>
    <a href="list.php" class="btn btn-secondary">&larr; Kembali</a>
</div>

<div class="form-container">
    <form action="proses_edit.php" method="POST">
        <input type="hidden" name="id" value="<?= htmlspecialchars($anggota['id']) ?>">

        <div class="form-group">
            <label for="nama">Nama Lengkap *</label>
            <input type="text" id="nama" name="nama" required value="<?= htmlspecialchars($anggota['nama']) ?>">
        </div>

        <div class="form-group">
            <label for="no_anggota">Nomor Anggota *</label>
            <input type="text" id="no_anggota" name="no_anggota" required value="<?= htmlspecialchars($anggota['no_anggota']) ?>">
        </div>

        <div class="form-group">
            <label for="alamat">Alamat</label>
            <input type="text" id="alamat" name="alamat" value="<?= htmlspecialchars($anggota['alamat'] ?? '') ?>">
        </div>

        <div class="form-group">
            <label for="no_hp">Nomor Handphone</label>
            <input type="text" id="no_hp" name="no_hp" value="<?= htmlspecialchars($anggota['no_hp'] ?? '') ?>">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
            <a href="list.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
