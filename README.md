# AIHealth Fullstack

## 📌 Project Overview

AIHealth Fullstack adalah aplikasi manajemen kesehatan terintegrasi yang didukung oleh Kecerdasan Buatan (AI). Sistem ini menyediakan pemantauan kesehatan secara real-time, konsultasi virtual, dan saran kesehatan yang dipersonalisasi melalui antarmuka yang ramah pengguna.

## ✨ Fitur

* Pemantauan kesehatan secara real-time
* Terapis virtual berbasis AI
* Saran kesehatan yang dipersonalisasi
* Autentikasi dan otorisasi yang aman
* Dashboard dengan analitik yang informatif
* Manajemen profil pengguna

## 🔧 Tech Stack

* **Frontend:** Flutter
* **Backend:** Laravel 12
* **Database:** Microsoft SQL Server
* **Authentication:** Laravel Sanctum
* **AI Integration:** OpenAI GPT API

## 🚀 Getting Started

Untuk memulai project ini secara lokal, ikuti langkah-langkah berikut:

### Prasyarat

* Flutter SDK
* Composer
* PHP 8.2+
* Microsoft SQL Server
* Laragon (menggunakan Nginx)

### Clone repository:

```bash
$ git clone https://github.com/ipoelamri/AIHEALTH_FULLSTACK.git
$ cd AIHEALTH_FULLSTACK
```

### Install dependencies:

```bash
$ composer install
$ flutter pub get
```

### Konfigurasi environment variables:

Salin contoh environment file dan sesuaikan konfigurasinya:

```bash
$ cp .env.example .env
```

Sesuaikan file `.env` dengan kredensial database dan API yang kamu gunakan.

### Generate application key:

```bash
$ php artisan key:generate
```

## ⚙️ Konfigurasi Database

* Update `.env` dengan kredensial database Microsoft SQL Server:

  ```env
  DB_CONNECTION=sqlsrv
  DB_HOST=127.0.0.1
  DB_PORT=1433
  DB_DATABASE=aihealth
  DB_USERNAME=sa
  DB_PASSWORD=admin.123
  ```

* Konfigurasi OpenAI API:

  ```env
  OPENAI_API_KEY=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
  ```

## 🎯 Menjalankan Aplikasi

Pastikan Laragon dan Nginx sudah berjalan. Kemudian jalankan perintah berikut:

```bash
$ php artisan serve
$ flutter run
```

Akses aplikasi di [http://localhost:8000](http://localhost:8000) untuk backend dan emulator/perangkat fisik untuk Flutter.

## 📌 Dokumentasi API

### 🔹 Endpoint Authentication:

| Method | Endpoint    | Keterangan             |
| ------ | ----------- | ---------------------- |
| POST   | `/register` | Mendaftarkan user baru |
| POST   | `/login`    | Login user             |
| POST   | `/logout`   | Logout user (Sanctum)  |

### 🔹 Endpoint User Data:

| Method | Endpoint                | Keterangan                         |
| ------ | ----------------------- | ---------------------------------- |
| GET    | `/user`                 | Mengambil data profil user         |
| POST   | `/update-bmi`           | Mengupdate data BMI user           |
| POST   | `/update-mental-health` | Mengupdate data mental health user |

### 🔹 Endpoint GPT Kesehatan:

| Method | Endpoint | Keterangan                          |
| ------ | -------- | ----------------------------------- |
| POST   | `/tanya` | Mengirim pertanyaan ke AIHealth GPT |

### 🔹 Endpoint Virtual Therapist:

| Method | Endpoint     | Keterangan                                   |
| ------ | ------------ | -------------------------------------------- |
| POST   | `/therapist` | Mengirim pertanyaan ke Virtual Therapist GPT |

> Catatan: Untuk mengakses endpoint yang berada dalam middleware `auth:sanctum`, Anda harus login terlebih dahulu dan menyertakan token autentikasi di header request.
>
Create By : Muhammad Saiful Amri
