# Panduan Upload ke GitHub

Berikut langkah-langkah untuk meng-upload project ini ke GitHub agar bisa kolaborasi.

## 1. Persiapan Awal
**PENTING:** Karena ini repository milik temanmu (`Ashlxxy`), pastikan kamu sudah **di-undang (invited) sebagai Collaborator** di repository tersebut. Jika belum, minta temanmu untuk menambahkan username GitHub kamu di:
`Settings` -> `Collaborators` -> `Add people`.

Jika tidak, kamu akan gagal saat melakukan `git push` (Permission denied).

## 2. Inisalisasi Git di Laptop
Buka terminal di root folder project ini, lalu jalankan perintah berikut satu per satu:

1.  **Inisialisasi Git:**
    ```bash
    git init
    ```

2.  **Masukkan semua file ke staging:**
    ```bash
    git add .
    ```

3.  **Commit pertama:**
    ```bash
    git commit -m "Initial commit: Aplikasi Tubes PBO"
    ```

4.  **Set Branch Utama (Optional, biasanya 'main'):**
    ```bash
    git branch -M main
    ```

5.  **Hubungkan ke GitHub:**
    *(Copy link repository kamu dari halaman GitHub yang tadi dibuat)*
    ```bash
    git remote add origin https://github.com/Ashlxxy/Tubes-Kelompok2-WebProPBO.git
    ```
    *(URL sudah saya update sesuai link yang diberikan)*

6.  **Upload (Push) ke GitHub:**
    ```bash
    git push -u origin main
    ```

## 3. Untuk Teman Kamu (Kolaborasi)
Setelah project ada di GitHub, teman kamu cukup melakukan:

1.  **Clone (Download) Repository:**
    ```bash
    git clone https://github.com/Ashlxxy/Tubes-Kelompok2-WebProPBO.git
    ```
2.  Masuk ke foldernya dan ikuti panduan di `HOW_TO_RUN.md` (gunakan Docker atau manual).
