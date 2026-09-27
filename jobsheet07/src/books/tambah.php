<?php
$page_title = "Tambah Buku";
require_once __DIR__ . '/../includes/header.php';
?>

<div class="page-header">
    <h2>Tambah Data Buku</h2>
    <a href="list.php" class="btn btn-secondary">&larr; Kembali</a>
</div>

<div class="form-container">
    <form action="proses_tambah.php" method="POST">
        <div class="form-group">
            <label for="judul">Judul Buku *</label>
            <input type="text" id="judul" name="judul" required placeholder="Contoh: Pemrograman Web dengan PHP">
        </div>

        <div class="form-group">
            <label for="pengarang">Pengarang *</label>
            <input type="text" id="pengarang" name="pengarang" required placeholder="Contoh: Dimas Wahyu">
        </div>

        <div class="form-group">
            <label for="tahun">Tahun Terbit *</label>
            <input type="number" id="tahun" name="tahun" required min="1900" max="2026" placeholder="2024">
        </div>

        <div class="form-group">
            <label for="isbn">ISBN</label>
            <input type="text" id="isbn" name="isbn" placeholder="978-602-xxx-xxx-x">
        </div>

        <div class="form-group">
            <label for="stok">Jumlah Stok *</label>
            <input type="number" id="stok" name="stok" required min="0" value="1">
        </div>

        <div class="form-group">
            <label for="kategori">Kategori</label>
            <input type="text" id="kategori" name="kategori" placeholder="Teknologi, Fiksi, Sains, dll.">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Simpan Buku</button>
            <a href="list.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
