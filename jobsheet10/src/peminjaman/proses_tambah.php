<?php
require_once __DIR__ . '/../includes/auth.php';
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: kembali.php');
    exit;
}

$anggota_id = $_POST['anggota_id'] ?? '';
$buku_id = $_POST['buku_id'] ?? '';
$tanggal_pinjam = $_POST['tanggal_pinjam'] ?? date('Y-m-d');

if ($anggota_id === '' || $buku_id === '') {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Anggota dan buku wajib dipilih.'];
    header('Location: tambah.php');
    exit;
}

try {
    $pdo->beginTransaction();

    $stmt_buku = $pdo->prepare("SELECT judul, stok FROM buku WHERE id = :id FOR UPDATE");
    $stmt_buku->execute([':id' => $buku_id]);
    $buku = $stmt_buku->fetch();

    if (!$buku || (int)$buku['stok'] < 1) {
        throw new Exception("Stok buku tidak mencukupi untuk dipinjam.");
    }

    $insert = $pdo->prepare(
        "INSERT INTO peminjaman (buku_id, anggota_id, tanggal_pinjam, status)
         VALUES (:buku_id, :anggota_id, :tanggal_pinjam, 'dipinjam')"
    );
    $insert->execute([
        ':buku_id' => $buku_id,
        ':anggota_id' => $anggota_id,
        ':tanggal_pinjam' => $tanggal_pinjam,
    ]);

    $update_stok = $pdo->prepare("UPDATE buku SET stok = stok - 1 WHERE id = :id");
    $update_stok->execute([':id' => $buku_id]);

    $pdo->commit();

    $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Peminjaman berhasil dicatat. Stok buku berkurang 1.'];
    header('Location: kembali.php');
    exit;
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal mencatat transaksi: ' . $e->getMessage()];
    header('Location: tambah.php');
    exit;
}
