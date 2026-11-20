package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model4.MembershipCard4;
import model4.SalesStaff4;

/**
 * DAO cho lớp thực thể MembershipCard4.
 */
public class MembershipCardDAO4 extends DAO {

    public MembershipCardDAO4() {
        super();
    }

    /**
     * Kiểm tra thẻ có tồn tại và còn hiệu lực hay không.
     */
    public boolean checkValid4(int idCard) {
        String sql = "SELECT status FROM tblMembershipCard4 WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCard);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && "ACTIVE".equalsIgnoreCase(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public MembershipCard4 getCardById4(int idCard) {
        String sql = "SELECT id, issueDate, status, tblSalesStaff4tblEmployee4tblMember4id "
                   + "FROM tblMembershipCard4 WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCard);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    MembershipCard4 card = new MembershipCard4();
                    card.setId(rs.getInt("id"));
                    card.setIssueDate(rs.getDate("issueDate"));
                    card.setStatus(rs.getString("status"));
                    int staffId = rs.getInt("tblSalesStaff4tblEmployee4tblMember4id");
                    if (!rs.wasNull()) {
                        SalesStaff4 staff = new SalesStaff4();
                        staff.setId(staffId);
                        card.setSalesStaff(staff);
                    }
                    return card;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
