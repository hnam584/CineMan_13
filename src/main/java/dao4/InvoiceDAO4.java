package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;
import model4.Invoice4;
import model4.Ticket4;

public class InvoiceDAO4 extends DAO {

    public InvoiceDAO4() {
        super();
    }

    public float calculateTotalAmount4(List<Ticket4> tickets) {
        float total = 0f;
        if (tickets != null) {
            for (Ticket4 ticket : tickets) {
                total += (float) ticket.getPrice();
            }
        }
        return total;
    }

    public boolean addInvoice4(Invoice4 invoice) {
        String insertInvoice =
                "INSERT INTO tblInvoice4 "
              + "(totalAmount, paymentDate, tblCustomer4tblMember4id, tblSalesStaff4tblEmployee4tblMember4id) "
              + "VALUES (?, ?, ?, ?)";
        String insertTicket =
                "INSERT INTO tblTicket4 "
              + "(price, status, holdUntil, tblSeat4id, tblShowtime4id, tblInvoice4id, tblCustomer4tblMember4id) "
              + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        if (invoice == null || invoice.getCustomer() == null) {
            return false;
        }

        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try {
                Timestamp paymentDate = invoice.getPaymentDate() == null
                        ? new Timestamp(System.currentTimeMillis())
                        : invoice.getPaymentDate();

                int invoiceId;
                try (PreparedStatement ps = con.prepareStatement(insertInvoice, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setFloat(1, invoice.getTotalAmount());
                    ps.setTimestamp(2, paymentDate);
                    ps.setInt(3, invoice.getCustomer().getId());
                    if (invoice.getSalesStaff() == null) {
                        ps.setNull(4, java.sql.Types.INTEGER);
                    } else {
                        ps.setInt(4, invoice.getSalesStaff().getId());
                    }
                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new IllegalStateException("Không lấy được id hóa đơn vừa tạo");
                        }
                        invoiceId = keys.getInt(1);
                    }
                }

                try (PreparedStatement ps = con.prepareStatement(insertTicket, Statement.RETURN_GENERATED_KEYS)) {
                    for (Ticket4 ticket : invoice.getTickets()) {
                        ps.setFloat(1, ticket.getPrice());
                        ps.setString(2, ticket.getStatus() == null ? "DA_BAN" : ticket.getStatus());
                        ps.setTimestamp(3, ticket.getHoldUntil());
                        ps.setInt(4, ticket.getSeat().getId());
                        ps.setInt(5, ticket.getShowtime().getId());
                        ps.setInt(6, invoiceId);
                        ps.setInt(7, invoice.getCustomer().getId());
                        ps.executeUpdate();

                        try (ResultSet keys = ps.getGeneratedKeys()) {
                            if (keys.next()) {
                                ticket.setId(keys.getInt(1));
                            }
                        }
                    }
                }

                con.commit();
                invoice.setId(invoiceId);
                invoice.setPaymentDate(paymentDate);
                return true;
            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
                return false;
            } finally {
                con.setAutoCommit(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void printInvoice4() {
        System.out.println("===> In vé và hóa đơn");
    }
}
