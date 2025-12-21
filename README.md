# Tubes PBO - Music Player Project

Proyek ini adalah aplikasi pemutar musik berbasis web yang dibangun sebagai Tugas Besar (Tubes) untuk mata kuliah Pemrograman Berorientasi Objek (PBO). Aplikasi ini awalnya dikonversi dari proyek Laravel ke Spring Boot (Java).

## 🚀 Fitur Utama

Aplikasi ini mencakup fitur-fitur berikut:
*   **Autentikasi Pengguna**: Login dan Registrasi untuk pengguna (User) dan admin.
*   **Manajemen Lagu**: Admin dapat menambahkan, mengedit, dan menghapus lagu.
*   **Pemutar Musik**: Memutar lagu dengan format `.wav`, menampilkan cover art, dan deskripsi.
*   **Playlist**: Pengguna dapat membuat playlist pribadi dan menambahkan lagu ke dalamnya.
*   **Like & History**: Fitur menyukai lagu dan riwayat pemutaran.
*   **Komentar & Masukan**: Pengguna dapat memberikan komentar pada lagu dan mengirim masukan/laporan.
*   **Dashboard Admin**: Statistik lagu terpopuler dan manajemen konten.

## 🛠 Teknologi yang Digunakan

*   **Bahasa Pemrograman**: Java 17
*   **Framework**: Spring Boot 3.2.0
*   **Database**: MySQL
*   **Frontend**: JSP (JavaServer Pages), JSTL, CSS (Bootstrap/Custom)
*   **Build Tool**: Maven

## 📋 Persyaratan Sistem

Sebelum menjalankan proyek, pastikan Anda telah menginstal:
*   **Java Development Kit (JDK) 17** atau lebih baru.
*   **Maven** (untuk build dan dependency management).
*   **MySQL Server**.

## ⚙️ Cara Menjalankan

Ikuti langkah-langkah berikut untuk menjalankan aplikasi:

1.  **Konfigurasi Database**
    *   Buat database baru di MySQL bernama `tubes_pbo`.
    *   Pastikan konfigurasi di `src/main/resources/application.properties` sesuai dengan user/password database Anda (default: root, tanpa password).
    ```properties
    spring.datasource.url=jdbc:mysql://localhost:3306/tubes_pbo?createDatabaseIfNotExist=true
    spring.datasource.username=root
    spring.datasource.password=
    ```

2.  **Jalankan Aplikasi**
    Buka terminal di direktori root proyek dan jalankan perintah:
    ```bash
    mvn spring-boot:run
    ```

3.  **Akses Aplikasi**
    Setelah aplikasi berjalan, buka browser dan akses:
    Example URL: `http://localhost:8080`

## 👤 Akun Default (Seeder)

Saat aplikasi pertama kali dijalankan, `DataSeeder` akan otomatis membuat akun default berikut:

| Role  | Email              | Password |
| :---  | :---               | :---     |
| **Admin** | `admin@example.com` | `password` |
| **User**  | `user@example.com`  | `password` |

## 📂 Struktur Proyek

*   `src/main/java/com/example/tubes`: Source code Java (Controller, Service, Repository, Entity).
*   `src/main/webapp/WEB-INF/jsp`: File tampilan (View) JSP.
*   `src/main/resources`: Konfigurasi aplikasi dan aset statis.
