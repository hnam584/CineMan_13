package dao4;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 * Lớp DAO chung: đọc cấu hình và mở kết nối MySQL.
 * Các lớp DAO cụ thể kế thừa lớp này.
 */
public class DAO {

    private static final Properties CONFIG = loadConfig();

    public DAO() {
    }

    /**
     * Mở một kết nối mới. Người gọi chịu trách nhiệm đóng (try-with-resources).
     */
    protected static Connection getConnection() throws Exception {
        String dbUrl = CONFIG.getProperty("db.url");
        String dbUser = CONFIG.getProperty("db.username");
        String dbPass = CONFIG.getProperty("db.password");

        if (dbUrl == null || dbUser == null || dbPass == null) {
            throw new IllegalStateException(
                    "Thiếu cấu hình db.url, db.username hoặc db.password trong db.properties");
        }

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(dbUrl, dbUser, dbPass);
    }

    private static Properties loadConfig() {
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
