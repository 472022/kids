# Kids Learning Platform

A child-friendly learning management system built with PHP and MySQL.

## Setup Instructions

1.  **Database Setup**:
    -   Open PHPMyAdmin (usually `http://localhost/phpmyadmin`).
    -   Import `database.sql`.
    -   This will create the `kids_learning` database and required tables.

2.  **Configuration**:
    -   Check `config/db.php` if you need to change database credentials (default: root/no password).

3.  **Running**:
    -   Place this folder in `htdocs`.
    -   Open `http://localhost/kids/index.php`.

## Features

-   **Home Page**: Landing page with child-friendly UI.
-   **Registration**: Parents can register themselves and their child in one go.
-   **Login**: Role-based login for Children, Parents, and Admins.
-   **Security**: Passwords are hashed using `password_hash` (Bcrypt).
-   **Architecture**: Modular PHP using PDO for database interactions.

## Default Credentials

-   **Admin**:
    -   Email: `admin@kids.com`
    -   Password: `hashedpassword`
