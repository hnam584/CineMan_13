package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model4.Ticket4;

public class TicketDAO4 extends DAO {

    public TicketDAO4() {
        super();
    }

    public boolean addTicket4(Ticket4 ticket, int invoiceDbId) {
        String sql = "INSERT INTO tblTicket4 (ticketId, price, Seat4id, Invoice4id, ShowTime4id) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, ticket.getTicketId());
            ps.setDouble(2, ticket.getPrice());
            ps.setInt(3, ticket.getSeatId());
            ps.setInt(4, invoiceDbId);
            ps.setInt(5, ticket.getShowtimeId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public double calculatePrice4(double ticketPrice, int quantity) {
        return ticketPrice * quantity;
    }
}
