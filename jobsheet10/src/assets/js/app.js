function initThemeToggle() {
    const btn = document.getElementById("theme-toggle-btn");
    if (!btn) return;

    const isDark = document.documentElement.classList.contains("dark-theme");
    btn.textContent = isDark ? "☀️" : "🌙";

    btn.addEventListener("click", function () {
        const isDarkNow = document.documentElement.classList.toggle("dark-theme");
        localStorage.setItem("theme", isDarkNow ? "dark" : "light");
        btn.textContent = isDarkNow ? "☀️" : "🌙";
    });
}

function initNavToggle() {
    const toggleBtn = document.getElementById("nav-toggle-btn");
    const nav = document.querySelector("header nav");
    if (!toggleBtn || !nav) return;

    toggleBtn.addEventListener("click", function () {
        nav.classList.toggle("nav-open");
    });
}

function initTableFilter() {
    const input = document.getElementById("search-input");
    const table = document.querySelector(".table-responsive table");
    if (!input || !table) return;

    input.addEventListener("input", function () {
        const keyword = input.value.toLowerCase().trim();
        const rows = table.querySelectorAll("tbody tr");

        rows.forEach(function (row) {
            if (row.children.length === 1 && row.children[0].getAttribute("colspan")) {
                return;
            }
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(keyword) ? "" : "none";
        });
    });
}

function showInlineError(input, message) {
    clearInlineError(input);
    input.classList.add("input-error");
    const errorEl = document.createElement("span");
    errorEl.className = "error-inline";
    errorEl.textContent = message;
    input.insertAdjacentElement("afterend", errorEl);
}

function clearInlineError(input) {
    input.classList.remove("input-error");
    const next = input.nextElementSibling;
    if (next && next.classList.contains("error-inline")) {
        next.remove();
    }
}

function initValidasiForm() {
    const forms = document.querySelectorAll("#form-tambah, #form-edit");
    if (!forms.length) return;

    forms.forEach(function (form) {
        form.addEventListener("input", function (e) {
            if (e.target.tagName === "INPUT" || e.target.tagName === "SELECT") {
                clearInlineError(e.target);
            }
        });

        form.addEventListener("submit", function (e) {
            let isValid = true;

            const judul = form.querySelector("[name='judul']");
            if (judul && judul.value.trim() === "") {
                showInlineError(judul, "Judul buku wajib diisi.");
                isValid = false;
            }

            const pengarang = form.querySelector("[name='pengarang']");
            if (pengarang && pengarang.value.trim() === "") {
                showInlineError(pengarang, "Nama pengarang wajib diisi.");
                isValid = false;
            }

            const tahun = form.querySelector("[name='tahun']");
            if (tahun) {
                const val = parseInt(tahun.value, 10);
                if (isNaN(val) || val < 1900 || val > 2026) {
                    showInlineError(tahun, "Tahun harus berupa angka antara 1900-2026.");
                    isValid = false;
                }
            }

            const stok = form.querySelector("[name='stok']");
            if (stok) {
                const val = parseInt(stok.value, 10);
                if (isNaN(val) || val < 0) {
                    showInlineError(stok, "Jumlah stok tidak boleh bernilai negatif.");
                    isValid = false;
                }
            }

            const nama = form.querySelector("[name='nama']");
            if (nama && nama.value.trim() === "") {
                showInlineError(nama, "Nama anggota wajib diisi.");
                isValid = false;
            }

            const noAnggota = form.querySelector("[name='no_anggota']");
            if (noAnggota && noAnggota.value.trim() === "") {
                showInlineError(noAnggota, "Nomor anggota wajib diisi.");
                isValid = false;
            }

            const anggotaSelect = form.querySelector("[name='anggota_id']");
            if (anggotaSelect && anggotaSelect.value === "") {
                showInlineError(anggotaSelect, "Pilih anggota peminjam terlebih dahulu.");
                isValid = false;
            }

            const bukuSelect = form.querySelector("[name='buku_id']");
            if (bukuSelect && bukuSelect.value === "") {
                showInlineError(bukuSelect, "Pilih buku yang akan dipinjam.");
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    });
}

function initActionConfirm() {
    document.addEventListener("submit", function (e) {
        const form = e.target;
        if (form.classList.contains("form-hapus") && !form.getAttribute("onsubmit")) {
            const confirmed = confirm("Apakah Anda yakin ingin menghapus data ini?");
            if (!confirmed) {
                e.preventDefault();
            }
        }
    });
}

document.addEventListener("DOMContentLoaded", function () {
    initThemeToggle();
    initNavToggle();
    initTableFilter();
    initValidasiForm();
    initActionConfirm();
});
