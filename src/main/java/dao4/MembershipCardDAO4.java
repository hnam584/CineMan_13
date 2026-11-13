package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model4.MembershipCard4;

public class MembershipCardDAO4 extends DAO {

    public MembershipCardDAO4() {
        super();
    }

    public MembershipCard4 getByCardId(String cardId) {
        String sql = "SELECT id, cardId, issueDate, status, Customer4Member4id "
                   + "FROM tblMembershipCard4 WHERE cardId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cardId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    MembershipCard4 card = new MembershipCard4();
                    card.setId(rs.getInt("id"));
                    card.setCardId(rs.getString("cardId"));
                    card.setIssueDate(rs.getDate("issueDate"));
                    card.setStatus(rs.getString("status"));
                    card.setCustomerMemberId(rs.getInt("Customer4Member4id"));
                    return card;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
