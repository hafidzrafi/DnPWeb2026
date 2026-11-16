<?php
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/csrf.php';
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

csrf_verify();

$id = $_POST['id'] ?? null;
if ($id) {
    try {
        $stmt = $pdo->prepare("DELETE FROM anggota WHERE id = :id");
        $stmt->execute([':id' => $id]);
        $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Anggota berhasil dihapus dari database.'];
    } catch (PDOException $e) {
    error_log('SIMPUS-Mini: ' . $e->getMessage());
        $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal menghapus anggota.'];
    }
}

header('Location: list.php');
exit;
