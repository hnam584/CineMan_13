-- =========================================================
-- CineMan - Cơ sở dữ liệu MySQL 8.0
-- Chạy file này một lần để tạo database và dữ liệu mẫu.
-- =========================================================

CREATE DATABASE IF NOT EXISTS cineman_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE cineman_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS tblTicket4;
DROP TABLE IF EXISTS tblInvoice4;
DROP TABLE IF EXISTS tblShowtime4;
DROP TABLE IF EXISTS tblSeat4;
DROP TABLE IF EXISTS tblScreeningRoom4;
DROP TABLE IF EXISTS tblMovie4;
DROP TABLE IF EXISTS tblMembershipCard4;
DROP TABLE IF EXISTS tblCustomer4;
DROP TABLE IF EXISTS tblEmployee4;
DROP TABLE IF EXISTS tblMember4;
SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
-- 1. Nhóm người dùng
-- =========================================================
CREATE TABLE tblMember4 (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(255) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    fullName    VARCHAR(255) NOT NULL,
    dateOfBirth DATE NULL,
    email       VARCHAR(255) NULL,
    phone       VARCHAR(255) NULL,
    address     VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblCustomer4 (
    Member4id   INT PRIMARY KEY,
    customerId  VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT fk_customer_member
        FOREIGN KEY (Member4id) REFERENCES tblMember4(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblEmployee4 (
    Member4id INT PRIMARY KEY,
    position  VARCHAR(255) NULL,
    CONSTRAINT fk_employee_member
        FOREIGN KEY (Member4id) REFERENCES tblMember4(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblMembershipCard4 (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    cardId             VARCHAR(255) NOT NULL UNIQUE,
    issueDate          DATE NULL,
    status             VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    Customer4Member4id INT NOT NULL,
    CONSTRAINT uq_card_customer UNIQUE (Customer4Member4id),
    CONSTRAINT fk_card_customer
        FOREIGN KEY (Customer4Member4id) REFERENCES tblCustomer4(Member4id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 2. Phim, phòng chiếu, ghế, lịch chiếu
-- =========================================================
CREATE TABLE tblMovie4 (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    movieId     VARCHAR(255) NOT NULL UNIQUE,
    movieName   VARCHAR(255) NOT NULL,
    description TEXT NULL,
    genre       VARCHAR(255) NULL,
    duration    INT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblScreeningRoom4 (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    roomId   VARCHAR(255) NOT NULL UNIQUE,
    capacity INT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblSeat4 (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    seatId           VARCHAR(255) NOT NULL,
    status           VARCHAR(50) NOT NULL DEFAULT 'TRONG',
    ScreeningRoom4id INT NOT NULL,
    CONSTRAINT uq_seat_room UNIQUE (ScreeningRoom4id, seatId),
    CONSTRAINT fk_seat_room
        FOREIGN KEY (ScreeningRoom4id) REFERENCES tblScreeningRoom4(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblShowtime4 (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    showtimeId       VARCHAR(255) NOT NULL UNIQUE,
    startTime        DATETIME NOT NULL,
    endTime          DATETIME NOT NULL,
    ticketPrice      DECIMAL(12,2) NOT NULL DEFAULT 90000,
    ScreeningRoom4id INT NOT NULL,
    Movie4id         INT NOT NULL,
    CONSTRAINT fk_showtime_room
        FOREIGN KEY (ScreeningRoom4id) REFERENCES tblScreeningRoom4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_showtime_movie
        FOREIGN KEY (Movie4id) REFERENCES tblMovie4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 3. Hóa đơn và vé
-- =========================================================
CREATE TABLE tblInvoice4 (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    invoiceId          VARCHAR(255) NOT NULL UNIQUE,
    totalAmount        DECIMAL(12,2) NOT NULL,
    paymentDate        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Customer4Member4id INT NOT NULL,
    Employee4Member4id INT NULL,
    CONSTRAINT fk_invoice_customer
        FOREIGN KEY (Customer4Member4id) REFERENCES tblCustomer4(Member4id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_employee
        FOREIGN KEY (Employee4Member4id) REFERENCES tblEmployee4(Member4id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblTicket4 (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    ticketId    VARCHAR(255) NOT NULL UNIQUE,
    price       DECIMAL(12,2) NOT NULL,
    Seat4id     INT NOT NULL,
    Invoice4id  INT NOT NULL,
    ShowTime4id INT NOT NULL,
    CONSTRAINT fk_ticket_seat
        FOREIGN KEY (Seat4id) REFERENCES tblSeat4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ticket_invoice
        FOREIGN KEY (Invoice4id) REFERENCES tblInvoice4(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ticket_showtime
        FOREIGN KEY (ShowTime4id) REFERENCES tblShowtime4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_ticket_showtime_seat UNIQUE (ShowTime4id, Seat4id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 4. Dữ liệu mẫu
-- =========================================================
INSERT INTO tblMember4
    (id, username, password, fullName, dateOfBirth, email, phone, address)
VALUES
    (1, 'customer', '123456', 'Khách hàng A', '2000-01-01',
        'customer@cineman.vn', '0900000001', 'Hà Nội'),
    (2, 'manager', '123456', 'Quản lý A', '1990-01-01',
        'manager@cineman.vn', '0900000002', 'Hà Nội');

INSERT INTO tblCustomer4 (Member4id, customerId) VALUES (1, 'C001');
INSERT INTO tblEmployee4 (Member4id, position) VALUES (2, 'Manager');

INSERT INTO tblMembershipCard4 (cardId, issueDate, status, Customer4Member4id)
VALUES ('LOYAL001', '2026-01-01', 'ACTIVE', 1);

INSERT INTO tblMovie4 (movieId, movieName, description, genre, duration)
VALUES
    ('M001', 'Movie A', 'Phim hành động mẫu', 'Hành động', 120),
    ('M002', 'Movie B', 'Phim hoạt hình mẫu', 'Hoạt hình', 90);

INSERT INTO tblScreeningRoom4 (roomId, capacity)
VALUES ('P01', 40), ('P02', 30);

INSERT INTO tblSeat4 (seatId, status, ScreeningRoom4id) VALUES
    ('A1', 'TRONG', 1), ('A2', 'TRONG', 1), ('A3', 'TRONG', 1), ('A4', 'TRONG', 1),
    ('A5', 'TRONG', 1), ('A6', 'TRONG', 1), ('A7', 'TRONG', 1), ('A8', 'TRONG', 1),
    ('A9', 'TRONG', 1), ('A10', 'TRONG', 1),
    ('B1', 'TRONG', 1), ('B2', 'TRONG', 1), ('B3', 'TRONG', 1), ('B4', 'TRONG', 1),
    ('B5', 'TRONG', 1), ('B6', 'TRONG', 1), ('B7', 'TRONG', 1), ('B8', 'TRONG', 1),
    ('B9', 'TRONG', 1), ('B10', 'TRONG', 1),
    ('C1', 'TRONG', 2), ('C2', 'TRONG', 2), ('C3', 'TRONG', 2), ('C4', 'TRONG', 2),
    ('C5', 'TRONG', 2), ('C6', 'TRONG', 2), ('C7', 'TRONG', 2), ('C8', 'TRONG', 2),
    ('C9', 'TRONG', 2), ('C10', 'TRONG', 2);

INSERT INTO tblShowtime4
    (showtimeId, startTime, endTime, ticketPrice, ScreeningRoom4id, Movie4id)
VALUES
    ('S001', '2026-11-15 18:00:00', '2026-11-15 20:00:00', 90000, 1, 1),
    ('S002', '2026-11-15 20:30:00', '2026-11-15 22:00:00', 90000, 1, 2),
    ('S003', '2026-11-16 18:00:00', '2026-11-16 20:00:00', 80000, 2, 1);
