<?php
/**
 * Jobsheet 11 - Keamanan Web Dasar
 * Skeleton includes/csrf.php - Proteksi CSRF
 */

// TODO: Langkah 1 - Buat fungsi csrf_token()
// Periksa apakah $_SESSION['csrf_token'] sudah ada. Jika belum, generate dengan bin2hex(random_bytes(32))
function csrf_token()
{
    // Implementasikan pembuatan token CSRF
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

// TODO: Langkah 2 - Buat fungsi csrf_field() untuk menyisipkan input hidden pada setiap form POST
function csrf_field()
{
    return '<input type="hidden" name="csrf_token" value="' . csrf_token() . '">';
}

// TODO: Langkah 3 - Buat fungsi csrf_verify() untuk memvalidasi token yang dikirim via $_POST
function csrf_verify()
{
    $token = $_POST['csrf_token'] ?? '';
    // Gunakan hash_equals() untuk mencegah timing attack
    if ($token === '' || !hash_equals($_SESSION['csrf_token'] ?? '', $token)) {
        http_response_code(403);
        die('Permintaan ditolak: token CSRF tidak valid atau kedaluwarsa.');
    }
}
