<?php
// Kredensial database dipisahkan dari kode halaman.
// Nilai diambil dari environment variable server; default di bawah hanya untuk
// pengembangan lokal dan bukan kredensial produksi. Jangan mengganti default
// dengan kredensial asli lalu meng-commit file ini.
return [
    'db_host' => getenv('DB_HOST') ?: 'localhost',
    'db_port' => getenv('DB_PORT') ?: '5432',
    'db_name' => getenv('DB_NAME') ?: 'simpus_mini',
    'db_user' => getenv('DB_USER') ?: 'postgres',
    'db_pass' => getenv('DB_PASS') ?: 'postgres',
];
