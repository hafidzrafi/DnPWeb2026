<?php
$page_title = "Tambah Anggota";
require_once __DIR__ . '/../includes/header.php';
?>

<div class="page-header">
    <h2>Tambah Data Anggota</h2>
    <a href="list.php" class="btn btn-secondary">&larr; Kembali</a>
</div>

<div class="form-container">
    <form action="proses_tambah.php" method="POST">
        <div class="form-group">
            <label for="nomor_anggota">Nomor Anggota *</label>
            <input type="text" id="nomor_anggota" name="nomor_anggota" required placeholder="Contoh: AG-001">
        </div>

        <div class="form-group">
            <label for="nama">Nama Lengkap *</label>
            <input type="text" id="nama" name="nama" required placeholder="Contoh: Ahmad Fauzi">
        </div>

        <div class="form-group">
            <label for="email">Email *</label>
            <input type="email" id="email" name="email" required placeholder="contoh@email.com">
        </div>

        <div class="form-group">
            <label for="telepon">Nomor Telepon</label>
            <input type="tel" id="telepon" name="telepon" placeholder="08123456789">
        </div>

        <div class="form-group">
            <label for="alamat">Alamat</label>
            <textarea id="alamat" name="alamat" rows="3" placeholder="Alamat lengkap..."></textarea>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Simpan Anggota</button>
            <a href="list.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
