<?php
require_once __DIR__ . '/../includes/auth.php';
session_start();
require_once __DIR__ . '/../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: kembali.php');
    exit;
}

$id = $_POST['id'] ?? null;
if (!$id) {
    header('Location: kembali.php');
    exit;
}

try {
    $pdo->beginTransaction();

    $stmt = $pdo->prepare("SELECT buku_id, status FROM peminjaman WHERE id = :id FOR UPDATE");
    $stmt->execute([':id' => $id]);
    $trx = $stmt->fetch();

    if (!$trx || $trx['status'] !== 'dipinjam') {
        throw new Exception("Transaksi tidak ditemukan atau buku sudah dikembalikan sebelumnya.");
    }

    $update_trx = $pdo->prepare(
        "UPDATE peminjaman SET status = 'dikembalikan', tanggal_kembali = CURRENT_DATE WHERE id = :id"
    );
    $update_trx->execute([':id' => $id]);

    $update_stok = $pdo->prepare("UPDATE buku SET stok = stok + 1 WHERE id = :buku_id");
    $update_stok->execute([':buku_id' => $trx['buku_id']]);

    $pdo->commit();

    $_SESSION['flash'] = ['type' => 'success', 'pesan' => 'Buku berhasil dikembalikan. Stok bertambah kembali 1.'];
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal memproses pengembalian: ' . $e->getMessage()];
}

header('Location: kembali.php');
exit;
