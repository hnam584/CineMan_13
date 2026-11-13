package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model4.Invoice4;
import model4.Ticket4;

public class InvoiceDAO4 extends DAO {

    public InvoiceDAO4() {
        super();
    }

    /**
     * Lưu hóa đơn và toàn bộ vé trong cùng một transaction.
     */
    public boolean addInvoice4(Invoice4 invoice) {
        String insertInvoice =
                "INSERT INTO tblInvoice4 "
              + "(invoiceId, totalAmount, paymentDate, Customer4Member4id, Employee4Member4id) "
              + "VALUES (?, ?, ?, ?, ?)";
        String insertTicket =
                "INSERT INTO tblTicket4 "
              + "(ticketId, price, Seat4id, Invoice4id, ShowTime4id) "
              + "VALUES (?, ?, ?, ?, ?)";

        try {
            con.setAutoCommit(false);

            int invoiceDbId;
            try (PreparedStatement ps = con.prepareStatement(insertInvoice, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, invoice.getInvoiceId());
                ps.setDouble(2, invoice.getTotalAmount());
                ps.setTimestamp(3, invoice.getPaymentDate());
                ps.setInt(4, invoice.getCustomerMemberId());
                if (invoice.getEmployeeMemberId() == null) {
                    ps.setNull(5, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(5, invoice.getEmployeeMemberId());
                }
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new IllegalStateException("Không lấy được id hóa đơn vừa tạo");
                    }
                    invoiceDbId = keys.getInt(1);
                }
            }

            try (PreparedStatement ps = con.prepareStatement(insertTicket)) {
                for (Ticket4 ticket : invoice.getTickets()) {
                    ps.setString(1, ticket.getTicketId());
                    ps.setDouble(2, ticket.getPrice());
                    ps.setInt(3, ticket.getSeatId());
                    ps.setInt(4, invoiceDbId);
                    ps.setInt(5, ticket.getShowtimeId());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit();
            return true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ignored) {
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ignored) {
            }
        }
    }

    public boolean createInvoice4(Invoice4 invoice) {
        return addInvoice4(invoice);
    }
}
