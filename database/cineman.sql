-- =========================================================
-- CineMan - Cơ sở dữ liệu MySQL 8.0 (theo ERD pha thiết kế)
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
DROP TABLE IF EXISTS tblManager4;
DROP TABLE IF EXISTS tblSalesStaff4;
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

CREATE TABLE tblEmployee4 (
    tblMember4id INT PRIMARY KEY,
    position     VARCHAR(255) NULL,
    CONSTRAINT fk_employee_member
        FOREIGN KEY (tblMember4id) REFERENCES tblMember4(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblManager4 (
    tblEmployee4tblMember4id INT PRIMARY KEY,
    CONSTRAINT fk_manager_employee
        FOREIGN KEY (tblEmployee4tblMember4id) REFERENCES tblEmployee4(tblMember4id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblSalesStaff4 (
    tblEmployee4tblMember4id INT PRIMARY KEY,
    CONSTRAINT fk_sales_employee
        FOREIGN KEY (tblEmployee4tblMember4id) REFERENCES tblEmployee4(tblMember4id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblCustomer4 (
    tblMember4id INT PRIMARY KEY,
    customerId   VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT fk_customer_member
        FOREIGN KEY (tblMember4id) REFERENCES tblMember4(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblMembershipCard4 (
    id                                    INT AUTO_INCREMENT PRIMARY KEY,
    issueDate                             DATE NULL,
    status                                VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    tblCustomer4tblMember4id              INT NOT NULL,
    tblSalesStaff4tblEmployee4tblMember4id INT NULL,
    CONSTRAINT uq_card_customer UNIQUE (tblCustomer4tblMember4id),
    CONSTRAINT fk_card_customer
        FOREIGN KEY (tblCustomer4tblMember4id) REFERENCES tblCustomer4(tblMember4id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_card_sales
        FOREIGN KEY (tblSalesStaff4tblEmployee4tblMember4id) REFERENCES tblSalesStaff4(tblEmployee4tblMember4id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 2. Phim, phòng chiếu, ghế, lịch chiếu
-- =========================================================
CREATE TABLE tblMovie4 (
    id                                     INT AUTO_INCREMENT PRIMARY KEY,
    movieName                              VARCHAR(255) NOT NULL,
    description                            TEXT NULL,
    genre                                  VARCHAR(255) NULL,
    duration                               INT NULL,
    tblManager4tblEmployee4tblMember4id    INT NOT NULL,
    CONSTRAINT fk_movie_manager
        FOREIGN KEY (tblManager4tblEmployee4tblMember4id) REFERENCES tblManager4(tblEmployee4tblMember4id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblScreeningRoom4 (
    id                                     INT AUTO_INCREMENT PRIMARY KEY,
    capacity                               INT NULL,
    tblManager4tblEmployee4tblMember4id    INT NOT NULL,
    CONSTRAINT fk_room_manager
        FOREIGN KEY (tblManager4tblEmployee4tblMember4id) REFERENCES tblManager4(tblEmployee4tblMember4id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblSeat4 (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    status              VARCHAR(50) NOT NULL DEFAULT 'TRONG',
    tblScreeningRoom4id INT NOT NULL,
    CONSTRAINT fk_seat_room
        FOREIGN KEY (tblScreeningRoom4id) REFERENCES tblScreeningRoom4(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblShowtime4 (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    startTime           DATETIME NOT NULL,
    endTime             DATETIME NOT NULL,
    ticketPrice         FLOAT NOT NULL DEFAULT 90000,
    tblScreeningRoom4id INT NOT NULL,
    tblMovie4id         INT NOT NULL,
    CONSTRAINT fk_showtime_room
        FOREIGN KEY (tblScreeningRoom4id) REFERENCES tblScreeningRoom4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_showtime_movie
        FOREIGN KEY (tblMovie4id) REFERENCES tblMovie4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 3. Hóa đơn và vé
-- =========================================================
CREATE TABLE tblInvoice4 (
    id                                     INT AUTO_INCREMENT PRIMARY KEY,
    totalAmount                            FLOAT NOT NULL,
    paymentDate                            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tblCustomer4tblMember4id               INT NOT NULL,
    tblSalesStaff4tblEmployee4tblMember4id INT NULL,
    CONSTRAINT fk_invoice_customer
        FOREIGN KEY (tblCustomer4tblMember4id) REFERENCES tblCustomer4(tblMember4id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_sales
        FOREIGN KEY (tblSalesStaff4tblEmployee4tblMember4id) REFERENCES tblSalesStaff4(tblEmployee4tblMember4id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblTicket4 (
    id                        INT AUTO_INCREMENT PRIMARY KEY,
    price                     FLOAT NOT NULL,
    status                    VARCHAR(50) NOT NULL DEFAULT 'DA_BAN',
    holdUntil                 DATETIME NULL,
    tblSeat4id                INT NOT NULL,
    tblShowtime4id            INT NOT NULL,
    tblInvoice4id             INT NULL,
    tblCustomer4tblMember4id  INT NOT NULL,
    CONSTRAINT fk_ticket_seat
        FOREIGN KEY (tblSeat4id) REFERENCES tblSeat4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ticket_showtime
        FOREIGN KEY (tblShowtime4id) REFERENCES tblShowtime4(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ticket_invoice
        FOREIGN KEY (tblInvoice4id) REFERENCES tblInvoice4(id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_ticket_customer
        FOREIGN KEY (tblCustomer4tblMember4id) REFERENCES tblCustomer4(tblMember4id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_ticket_showtime_seat UNIQUE (tblShowtime4id, tblSeat4id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================================
-- 4. Dữ liệu mẫu
-- =========================================================
INSERT INTO tblMember4
    (id, username, password, fullName, dateOfBirth, email, phone, address)
VALUES
    (1, 'manager', '123456', 'Quản lý A', '1990-01-01',
        'manager@cineman.vn', '0900000001', 'Hà Nội'),
    (2, 'customer', '123456', 'Khách hàng A', '2000-01-01',
        'customer@cineman.vn', '0900000002', 'Hà Nội'),
    (3, 'sales', '123456', 'Nhân viên bán hàng A', '1998-01-01',
        'sales@cineman.vn', '0900000003', 'Hà Nội');

INSERT INTO tblEmployee4 (tblMember4id, position) VALUES
    (1, 'Manager'),
    (3, 'Sales Staff');

INSERT INTO tblManager4 (tblEmployee4tblMember4id) VALUES (1);
INSERT INTO tblSalesStaff4 (tblEmployee4tblMember4id) VALUES (3);
INSERT INTO tblCustomer4 (tblMember4id, customerId) VALUES (2, 'C001');

INSERT INTO tblMembershipCard4
    (id, issueDate, status, tblCustomer4tblMember4id, tblSalesStaff4tblEmployee4tblMember4id)
VALUES
    (1, '2026-01-01', 'ACTIVE', 2, 3);

INSERT INTO tblMovie4
    (id, movieName, description, genre, duration, tblManager4tblEmployee4tblMember4id)
VALUES
    (1, 'Movie A', 'Phim hành động mẫu', 'Hành động', 120, 1),
    (2, 'Movie B', 'Phim hoạt hình mẫu', 'Hoạt hình', 90, 1);

INSERT INTO tblScreeningRoom4 (id, capacity, tblManager4tblEmployee4tblMember4id)
VALUES (1, 40, 1), (2, 30, 1);

-- Phòng 1: 20 ghế, phòng 2: 10 ghế
INSERT INTO tblSeat4 (id, status, tblScreeningRoom4id) VALUES
    (1, 'TRONG', 1), (2, 'TRONG', 1), (3, 'TRONG', 1), (4, 'TRONG', 1), (5, 'TRONG', 1),
    (6, 'TRONG', 1), (7, 'TRONG', 1), (8, 'TRONG', 1), (9, 'TRONG', 1), (10, 'TRONG', 1),
    (11, 'TRONG', 1), (12, 'TRONG', 1), (13, 'TRONG', 1), (14, 'TRONG', 1), (15, 'TRONG', 1),
    (16, 'TRONG', 1), (17, 'TRONG', 1), (18, 'TRONG', 1), (19, 'TRONG', 1), (20, 'TRONG', 1),
    (21, 'TRONG', 2), (22, 'TRONG', 2), (23, 'TRONG', 2), (24, 'TRONG', 2), (25, 'TRONG', 2),
    (26, 'TRONG', 2), (27, 'TRONG', 2), (28, 'TRONG', 2), (29, 'TRONG', 2), (30, 'TRONG', 2);

INSERT INTO tblShowtime4
    (id, startTime, endTime, ticketPrice, tblScreeningRoom4id, tblMovie4id)
VALUES
    (1, '2026-11-21 18:00:00', '2026-11-21 20:00:00', 90000, 1, 1),
    (2, '2026-11-21 20:30:00', '2026-11-21 22:00:00', 90000, 1, 2),
    (3, '2026-11-22 18:00:00', '2026-11-22 20:00:00', 80000, 2, 1);
