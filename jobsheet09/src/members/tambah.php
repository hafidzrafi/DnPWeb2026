<?php
$page_title = "Tambah Anggota";
require_once __DIR__ . '/../includes/header.php';
?>

<div class="page-header">
    <h2>Tambah Data Anggota (PostgreSQL)</h2>
    <a href="list.php" class="btn btn-secondary">&larr; Kembali</a>
</div>

<div class="form-container">
    <form action="proses_tambah.php" method="POST">
        <div class="form-group">
            <label for="no_anggota">Nomor Anggota *</label>
            <input type="text" id="no_anggota" name="no_anggota" required placeholder="Contoh: AG-001">
        </div>

        <div class="form-group">
            <label for="nama">Nama Lengkap *</label>
            <input type="text" id="nama" name="nama" required placeholder="Contoh: Budi Santoso">
        </div>

        <div class="form-group">
            <label for="no_hp">Nomor HP</label>
            <input type="tel" id="no_hp" name="no_hp" placeholder="08123456789">
        </div>

        <div class="form-group">
            <label for="alamat">Alamat</label>
            <textarea id="alamat" name="alamat" rows="3" placeholder="Alamat tinggal..."></textarea>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Simpan ke Database</button>
            <a href="list.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
