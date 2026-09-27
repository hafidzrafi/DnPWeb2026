<?php
$page_title = "Login Pengguna";
require_once __DIR__ . '/../includes/header.php';
?>

<div class="auth-container">
    <h2>Login SIMPUS-Mini</h2>
    <p>Masukkan username dan password untuk mengakses sistem.</p>

    <form action="proses_login.php" method="POST">
        <div class="form-group">
            <label for="username">Username *</label>
            <input type="text" id="username" name="username" required placeholder="Username">
        </div>

        <div class="form-group">
            <label for="password">Password *</label>
            <input type="password" id="password" name="password" required placeholder="Password">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Masuk</button>
            <a href="register.php" class="btn btn-secondary">Belum punya akun? Register</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../includes/footer.php'; ?>
