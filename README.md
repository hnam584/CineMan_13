# CineMan

Bài nộp môn **Phân tích và Thiết kế hệ thống thông tin**.

Hệ thống quản lý rạp chiếu phim CineMan, gồm 2 module:

- Quản lý phim: thêm phim, hiển thị danh sách phim.
- Mua vé trực tuyến: chọn phim, suất chiếu, ghế, thanh toán và xuất hóa đơn.

Công nghệ: Java 17, JSP/Servlet, Maven, MySQL 8.0, Apache Tomcat 10.1.

## Chạy dự án

1. Import `database/cineman.sql` vào MySQL.
2. Cấu hình `src/main/resources/db.properties`.
3. Build: `mvn clean package`.
4. Deploy file WAR lên Tomcat.

Tài khoản demo:

```text
manager   / 123456
customer  / 123456
customer2 / 123456
customer3 / 123456
customer4 / 123456
sales     / 123456
```
