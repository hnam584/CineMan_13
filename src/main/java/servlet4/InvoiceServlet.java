package servlet4;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao4.InvoiceDAO4;
import dao4.MembershipCardDAO4;
import dao4.SeatDAO4;
import dao4.ShowtimeDAO4;
import model4.Invoice4;
import model4.MembershipCard4;
import model4.Seat4;
import model4.Showtime4;
import model4.Ticket4;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String showtimeId = request.getParameter("showtimeId");
        String loyaltyCode = request.getParameter("loyaltyCode");
        String[] seatIdParams = request.getParameterValues("seatIds");

        if (showtimeId == null || showtimeId.trim().isEmpty()
                || seatIdParams == null || seatIdParams.length == 0) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        ShowtimeDAO4 showtimeDAO = new ShowtimeDAO4();
        Showtime4 showtime = showtimeDAO.getShowtimeByCode(showtimeId);
        if (showtime == null) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        Set<Integer> selectedIds = new HashSet<>();
        for (String id : seatIdParams) {
            selectedIds.add(Integer.parseInt(id));
        }

        SeatDAO4 seatDAO = new SeatDAO4();
        List<Seat4> allSeats = seatDAO.getSeatsByShowtime4(showtimeId);
        List<Seat4> selectedSeats = new ArrayList<>();
        boolean invalidSeat = false;

        for (Seat4 seat : allSeats) {
            if (selectedIds.contains(seat.getId())) {
                selectedSeats.add(seat);
                if (!seat.isAvailable()) {
                    invalidSeat = true;
                }
            }
        }
        if (selectedSeats.size() != selectedIds.size()) {
            invalidSeat = true;
        }

        boolean appliedDiscount = false;
        if (!invalidSeat && loyaltyCode != null && !loyaltyCode.trim().isEmpty()) {
            MembershipCardDAO4 cardDAO = new MembershipCardDAO4();
            MembershipCard4 card = cardDAO.getByCardId(loyaltyCode.trim());
            appliedDiscount = card != null && card.isActive();
        }

        double discountRate = appliedDiscount ? 0.10 : 0.0;
        double unitPrice = showtime.getTicketPrice() * (1 - discountRate);
        double totalAmount = unitPrice * selectedSeats.size();

        boolean saved = false;
        Invoice4 invoice = null;

        if (!invalidSeat) {
            String suffix = UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase();
            invoice = new Invoice4();
            invoice.setInvoiceId("HD-" + suffix);
            invoice.setTotalAmount(totalAmount);
            invoice.setPaymentDate(new Timestamp(System.currentTimeMillis()));
            invoice.setCustomerMemberId(1);
            invoice.setEmployeeMemberId(null);

            int index = 1;
            for (Seat4 seat : selectedSeats) {
                Ticket4 ticket = new Ticket4();
                ticket.setTicketId("VE-" + suffix + "-" + index++);
                ticket.setPrice(unitPrice);
                ticket.setSeatId(seat.getId());
                ticket.setShowtimeId(showtime.getId());
                ticket.setSeatCode(seat.getSeatId());
                ticket.setShowtimeCode(showtime.getShowtimeId());
                invoice.getTickets().add(ticket);
            }

            InvoiceDAO4 invoiceDAO = new InvoiceDAO4();
            saved = invoiceDAO.addInvoice4(invoice);
        }

        request.setAttribute("showtime", showtime);
        request.setAttribute("invoice", invoice);
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("invalidSeat", invalidSeat);
        request.setAttribute("saved", saved);
        request.getRequestDispatcher("/ExportInvoiceInterface4.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/movies");
    }
}
