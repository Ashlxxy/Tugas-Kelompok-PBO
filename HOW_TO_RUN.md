# How to Run "Tubes PBO Project"

Panduan ini akan membantu teman kamu untuk menjalankan project ini di laptop mereka.

## 1. Prerequisites (Persyaratan)

Pastikan software berikut sudah terinstall di laptop:

*   **Java JDK 17** (atau versi yang lebih baru).
*   **Maven** (untuk build dan run project).
*   **MySQL Server**.

## 2. Setup Database

Project ini menggunakan MySQL. Sebelum menjalankan aplikasi, buat database terlebih dahulu.

1.  Buka MySQL Client (Workbench, phpMyAdmin, atau via terminal).
2.  Buat database baru dengan nama `tubes_pbo`:
    ```sql
    CREATE DATABASE tubes_pbo;
    ```
    *(Aplikasi sudah disetting untuk otomatis membuat tabel `createDatabaseIfNotExist=true` dan `ddl-auto=update`)*.

## 3. Konfigurasi Database

Cek file konfigurasi di `src/main/resources/application.properties`.
Secara default settingannya adalah:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/tubes_pbo?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=
```

*   Jika MySQL di laptop temanmu menggunakan **password**, ubah bagian `spring.datasource.password=` dengan password mereka.
*   Jika port MySQL bukan 3306, sesuaikan di bagian `url`.

## 4. Menjalankan Aplikasi

Buka terminal (CMD / PowerShell / Terminal) di folder root project ini, lalu jalankan perintah berikut:

1.  **Download dependencies & Build:**
    ```bash
    mvn clean install
    ```
    *(Tunggu sampai proses download selesai dan muncul "BUILD SUCCESS")*

2.  **Run Project:**
    ```bash
    mvn spring-boot:run
    ```

## 5. Mengakses Aplikasi

Setelah muncul log yang mengatakan aplikasi sudah berjalan (biasanya "Started TubesPboApplication..."), buka browser dan akses:

**http://localhost:8080**


## Option 2: Running with Docker (Recommended)

Jika teman kamu malas ribet install Java & MySQL satu per satu, gunakan cara ini (hanya butuh Docker Desktop).

1.  **Install Docker Desktop.**
2.  Buka terminal di folder project ini.
3.  Jalankan Docker Compose:
    ```bash
    docker-compose up --build
    ```
    *(Note: Proses pertama kali akan memakan waktu untuk mendownload dependencies dan membangun aplikasi secara otomatis)*.

Tunggu sampai setup database & aplikasi selesai. Aplikasi akan bisa diakses di **http://localhost:8081** (sesuai konfigurasi docker-compose).
