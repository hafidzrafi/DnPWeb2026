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
try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    // Catatan: Saat praktikum, tampilkan pesan error koneksi
    $db_error = $e->getMessage();
}
