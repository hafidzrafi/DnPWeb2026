<?php
$config = require __DIR__ . '/config.php';

// Local PostgreSQL runs without TLS while most hosts require sslmode=require.
// The default follows the host; DB_SSLMODE=disable relaxes it for local work.
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
    error_log('SIMPUS-Mini koneksi: ' . $e->getMessage());
    http_response_code(500);
    exit('Koneksi database tidak tersedia. Silakan coba kembali.');
}
