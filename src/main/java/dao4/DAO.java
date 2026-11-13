package dao4;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DAO {
    protected Connection con;

    public DAO() {
        if (con == null) {
            Properties config = loadConfig();
            String dbUrl = config.getProperty("db.url");
            String dbUser = config.getProperty("db.username");
            String dbPass = config.getProperty("db.password");

            if (dbUrl == null || dbUser == null || dbPass == null) {
                throw new IllegalStateException(
                        "Thiếu cấu hình db.url, db.username hoặc db.password trong db.properties");
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                System.out.println("===> KẾT NỐI MYSQL THÀNH CÔNG!");
            } catch (Exception e) {
                System.err.println("===> LỖI KẾT NỐI MYSQL:");
                e.printStackTrace();
                throw new RuntimeException("Không thể kết nối đến cơ sở dữ liệu", e);
            }
        }
    }

    private Properties loadConfig() {
        Properties properties = new Properties();
        try (InputStream input = DAO.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new IllegalStateException(
                        "Không tìm thấy db.properties trong classpath. " +
                        "Hãy sao chép db.properties.example thành db.properties và điền thông tin.");
            }
            properties.load(input);
            return properties;
        } catch (IllegalStateException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi đọc file db.properties", e);
        }
    }
}
