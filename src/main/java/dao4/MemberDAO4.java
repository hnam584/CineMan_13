package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model4.Customer4;
import model4.Manager4;
import model4.Member4;
import model4.SalesStaff4;

/**
 * DAO phục vụ đăng nhập (không thuộc phạm vi 2 modul nghiệp vụ).
 */
public class MemberDAO4 extends DAO {

    public MemberDAO4() {
        super();
    }

    /**
     * Xác thực đăng nhập và trả về đúng lớp con theo vai trò.
     */
    public Member4 authenticate(String username, String password) {
        String sql =
                "SELECT m.id, m.username, m.fullName, m.dateOfBirth, m.email, m.phone, m.address, "
              + "e.position, c.customerId "
              + "FROM tblMember4 m "
              + "LEFT JOIN tblEmployee4 e ON e.tblMember4id = m.id "
              + "LEFT JOIN tblCustomer4 c ON c.tblMember4id = m.id "
              + "WHERE m.username = ? AND m.password = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                String position = rs.getString("position");
                String customerId = rs.getString("customerId");

                Member4 member;
                if (position != null && "Manager".equalsIgnoreCase(position)) {
                    Manager4 manager = new Manager4();
                    manager.setPosition(position);
                    member = manager;
                } else if (position != null) {
                    SalesStaff4 staff = new SalesStaff4();
                    staff.setPosition(position);
                    member = staff;
                } else if (customerId != null) {
                    Customer4 customer = new Customer4();
                    customer.setCustomerId(customerId);
                    member = customer;
                } else {
                    return null;
                }

                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setFullName(rs.getString("fullName"));
                member.setDateOfBirth(rs.getDate("dateOfBirth"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                member.setAddress(rs.getString("address"));
                return member;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
