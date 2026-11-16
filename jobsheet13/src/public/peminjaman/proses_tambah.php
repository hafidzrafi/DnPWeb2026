<?php
require_once __DIR__ . '/../../includes/auth.php';
require_once __DIR__ . '/../../includes/csrf.php';
require_once __DIR__ . '/../../includes/koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: kembali.php');
    exit;
}

csrf_verify();

$anggota_id = $_POST['anggota_id'] ?? '';
$buku_id = $_POST['buku_id'] ?? '';
$tanggal_pinjam = $_POST['tanggal_pinjam'] ?? '';

if ($anggota_id === '' || $buku_id === '') {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Anggota dan buku wajib dipilih.'];
    header('Location: tambah.php');
    exit;
}

$tanggal = DateTime::createFromFormat('Y-m-d', $tanggal_pinjam);
if ($tanggal === false) {
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Format tanggal pinjam tidak valid.'];
    header('Location: tambah.php');
    exit;
}
$tanggal_pinjam = $tanggal->format('Y-m-d');

try {
    $pdo->beginTransaction();

    $cek_terlambat = $pdo->prepare(
        "SELECT COUNT(*) FROM peminjaman
         WHERE anggota_id = :anggota_id
           AND status = 'dipinjam'
           AND tanggal_pinjam < CURRENT_DATE - INTERVAL '14 days'"
    );
    $cek_terlambat->execute([':anggota_id' => $anggota_id]);
    if ((int) $cek_terlambat->fetchColumn() > 0) {
        throw new Exception('Anggota masih memiliki pinjaman aktif lebih dari 14 hari.');
    }

    $stmt_buku = $pdo->prepare("SELECT judul, stok FROM buku WHERE id = :id FOR UPDATE");
    $stmt_buku->execute([':id' => $buku_id]);
    $buku = $stmt_buku->fetch();

    if (!$buku || (int) $buku['stok'] < 1) {
        throw new Exception('Stok buku tidak tersedia.');
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
} catch (PDOException $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log('SIMPUS-Mini: ' . $e->getMessage());
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => 'Gagal mencatat transaksi karena kesalahan database.'];
    header('Location: tambah.php');
    exit;
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    $_SESSION['flash'] = ['type' => 'error', 'pesan' => $e->getMessage()];
    header('Location: tambah.php');
    exit;
}
