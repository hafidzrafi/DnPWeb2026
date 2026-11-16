<?php
/**
 * Jobsheet 08 - Koneksi PostgreSQL
 * Skeleton includes/koneksi.php
 */

// Konfigurasi Database PostgreSQL
$host = "localhost"; // atau "postgres" jika menggunakan container/docker
$port = "5432";
$db   = "simpus_mini";
$user = "postgres";
$pass = "postgres";

// TODO: Buat objek PDO dan hubungkan ke database PostgreSQL
// Gunakan blok try...catch untuk menangani PDOException
// PostgreSQL lokal biasanya berjalan tanpa TLS, sedangkan penyedia hosting
// mewajibkan sslmode=require. Nilai default mengikuti kebutuhan hosting dan
// dapat diturunkan lewat DB_SSLMODE=disable saat pengembangan lokal.
$ssl_mode = getenv('DB_SSLMODE') ?: 'require';

try {
    $dsn = "pgsql:host={$config['db_host']};"
         . "port={$config['db_port']};"
         . "dbname={$config['db_name']};"
         . "sslmode={$ssl_mode}";

    $pdo = new PDO($dsn, $config['db_user'], $config['db_pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    // Catatan: Saat praktikum, tampilkan pesan error koneksi
    error_log('SIMPUS-Mini koneksi: ' . $e->getMessage());
    http_response_code(500);
    exit('Koneksi database tidak tersedia. Silakan coba kembali.');
}
