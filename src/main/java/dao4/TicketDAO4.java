package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Set;
import model4.Ticket4;

public class TicketDAO4 extends DAO {

    public TicketDAO4() {
        super();
    }

    public Set<Integer> getSoldSeatIds4(int idShowtime) {
        Set<Integer> sold = new HashSet<>();
        String sql = "SELECT tblSeat4id FROM tblTicket4 "
                   + "WHERE tblShowtime4id = ? AND status = 'DA_BAN'";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idShowtime);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sold.add(rs.getInt("tblSeat4id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sold;
    }

    public float calculatePrice4(float ticketPrice) {
        return ticketPrice;
    }

    public boolean addTicket4(Ticket4 ticket, int idInvoice) {
        String sql = "INSERT INTO tblTicket4 "
                   + "(price, status, holdUntil, tblSeat4id, tblShowtime4id, tblInvoice4id, tblCustomer4tblMember4id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setFloat(1, ticket.getPrice());
            ps.setString(2, ticket.getStatus() == null ? "DA_BAN" : ticket.getStatus());
            ps.setTimestamp(3, ticket.getHoldUntil());
            ps.setInt(4, ticket.getSeat().getId());
            ps.setInt(5, ticket.getShowtime().getId());
            ps.setInt(6, idInvoice);
            ps.setInt(7, ticket.getCustomer().getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
