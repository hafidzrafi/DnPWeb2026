<?php
require_once __DIR__ . '/../includes/auth.php';
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: list.php');
    exit;
}

$id = $_POST['id'] ?? null;
if ($id) {
    try {
        $stmt = $pdo->prepare("DELETE FROM buku WHERE id = :id");
        $stmt->execute([':id' => $id]);
        $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Buku berhasil dihapus dari database.'];
    } catch (PDOException $e) {
        $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal menghapus buku: ' . $e->getMessage()];
    }
}

header('Location: list.php');
exit;
