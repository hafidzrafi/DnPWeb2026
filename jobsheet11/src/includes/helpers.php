<?php
/**
 * Jobsheet 11 - Keamanan Web Dasar
 * Skeleton includes/helpers.php - Proteksi XSS (Cross-Site Scripting)
 */

// TODO: Buat fungsi sanitasi e($value) yang membungkus htmlspecialchars() dengan ENT_QUOTES
function e($value)
function e($value): string
{
    return htmlspecialchars((string) ($value ?? ''), ENT_QUOTES, 'UTF-8');
}
