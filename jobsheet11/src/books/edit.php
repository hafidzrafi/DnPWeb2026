<?php
$page_title = "Edit Buku";
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/koneksi.php';

$id = $_GET['id'] ?? null;
// TODO: Ambil data buku yang akan diedit berdasarkan $id dari database
// $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = :id");
// $stmt->execute([':id' => $id]);
// $buku = $stmt->fetch();
$buku = null;
?>

<div class="page-header">
    <h2>Edit Data Buku</h2>
    <a href="list.php" class="btn btn-secondary">&larr; Kembali</a>
</div>

<div class="form-container">
    <form action="proses_edit.php" method="POST">
        <input type="hidden" name="id" value="<?= htmlspecialchars($id ?? '') ?>">

        <div class="form-group">
            <label for="judul">Judul Buku *</label>
            <input type="text" id="judul" name="judul" required value="<?= htmlspecialchars($buku['judul'] ?? '') ?>">
        </div>

        <div class="form-group">
            <label for="pengarang">Pengarang *</label>
            <input type="text" id="pengarang" name="pengarang" required value="<?= htmlspecialchars($buku['pengarang'] ?? '') ?>">
        </div>

        <div class="form-group">
            <label for="tahun">Tahun Terbit *</label>
            <input type="number" id="tahun" name="tahun" required min="1900" max="2026" value="<?= htmlspecialchars($buku['tahun'] ?? '2024') ?>">
        </div>

        <div class="form-group">
            <label for="isbn">ISBN</label>
            <input type="text" id="isbn" name="isbn" value="<?= htmlspecialchars($buku['isbn'] ?? '') ?>">
        </div>

        <div class="form-group">
            <label for="stok">Jumlah Stok *</label>
            <input type="number" id="stok" name="stok" required min="0" value="<?= htmlspecialchars($buku['stok'] ?? '1') ?>">
        </div>

        <div class="form-group">
            <label for="kategori">Kategori</label>
            <input type="text" id="kategori" name="kategori" value="<?= htmlspecialchars($buku['kategori'] ?? '') ?>">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
            <a href="list.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
