<?php
$page_title = "Register Pengguna Baru";
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if (isset($_SESSION['user'])) {
    header('Location: ../index.php');
    exit;
}
require_once __DIR__ . '/../includes/header.php';
?>

<div class="auth-container">
    <h2>Registrasi Akun Baru</h2>
    <p>Daftarkan akun petugas perpustakaan baru.</p>

    <form action="proses_register.php" method="POST">
        <div class="form-group">
            <label for="nama">Nama Lengkap *</label>
            <input type="text" id="nama" name="nama" required placeholder="Nama Lengkap">
        </div>

        <div class="form-group">
            <label for="username">Username *</label>
            <input type="text" id="username" name="username" required placeholder="Pilih username unik">
        </div>

        <div class="form-group">
            <label for="password">Password *</label>
            <input type="password" id="password" name="password" required minlength="6" placeholder="Minimal 6 karakter">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Daftar Sekarang</button>
            <a href="login.php" class="btn btn-secondary">Sudah punya akun? Login</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
