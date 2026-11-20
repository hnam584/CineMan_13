package servlet4;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao4.InvoiceDAO4;
import dao4.MembershipCardDAO4;
import dao4.SeatDAO4;
import dao4.ShowtimeDAO4;
import dao4.TicketDAO4;
import model4.Customer4;
import model4.Invoice4;
import model4.Member4;
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

        HttpSession session = request.getSession(false);
        Member4 member = session == null ? null : (Member4) session.getAttribute("member");
        if (!(member instanceof Customer4)) {
            response.sendRedirect(request.getContextPath() + "/CinemaInterface4.jsp");
            return;
        }
        Customer4 customer = (Customer4) member;

        int showtimeId;
        try {
            showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        String[] seatIdParams = request.getParameterValues("seatIds");
        if (seatIdParams == null || seatIdParams.length == 0) {
            response.sendRedirect(request.getContextPath() + "/seats?showtimeId=" + showtimeId);
            return;
        }

        ShowtimeDAO4 showtimeDAO = new ShowtimeDAO4();
        Showtime4 showtime = showtimeDAO.getShowtimeById4(showtimeId);
        if (showtime == null) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        SeatDAO4 seatDAO = new SeatDAO4();
        List<Seat4> allSeats = seatDAO.getSeatsByRoom4(showtime.getRoom().getId());
        TicketDAO4 ticketDAO = new TicketDAO4();
        Set<Integer> soldSeatIds = ticketDAO.getSoldSeatIds4(showtimeId);

        Set<Integer> selectedIds = new HashSet<>();
        for (String value : seatIdParams) {
            try {
                selectedIds.add(Integer.parseInt(value));
            } catch (NumberFormatException ignored) {
            }
        }

        List<Seat4> selectedSeats = new ArrayList<>();
        boolean invalidSeat = false;
        for (Seat4 seat : allSeats) {
            if (selectedIds.contains(seat.getId())) {
                selectedSeats.add(seat);
                if (soldSeatIds.contains(seat.getId())) {
                    invalidSeat = true;
                }
            }
        }
        if (selectedSeats.size() != selectedIds.size()) {
            invalidSeat = true;
        }

        String cardIdText = request.getParameter("cardId");
        boolean appliedDiscount = false;
        if (cardIdText != null && !cardIdText.trim().isEmpty()) {
            try {
                int cardId = Integer.parseInt(cardIdText.trim());
                MembershipCardDAO4 cardDAO = new MembershipCardDAO4();
                appliedDiscount = cardDAO.checkValid4(cardId);
            } catch (NumberFormatException ignored) {
            }
        }

        float unitPrice = ticketDAO.calculatePrice4(showtime.getTicketPrice());
        if (appliedDiscount) {
            unitPrice = unitPrice * 0.9f;
        }
        float totalAmount = unitPrice * selectedSeats.size();

        String expectedCode = (String) session.getAttribute("paymentCode");
        Integer paidShowtimeId = (Integer) session.getAttribute("paymentShowtimeId");
        String paidSeatIds = (String) session.getAttribute("paymentSeatIds");
        String enteredCode = request.getParameter("confirmCode");
        String currentSeatIds = new java.util.TreeSet<>(selectedIds).toString();

        boolean validConfirmation = expectedCode != null
                && enteredCode != null
                && expectedCode.equals(enteredCode.trim())
                && paidShowtimeId != null
                && paidShowtimeId.intValue() == showtimeId
                && currentSeatIds.equals(paidSeatIds);

        if (!invalidSeat && !validConfirmation) {
            request.setAttribute("showtime", showtime);
            request.setAttribute("selectedSeats", selectedSeats);
            request.setAttribute("cardId", cardIdText == null ? "" : cardIdText.trim());
            request.setAttribute("appliedDiscount", appliedDiscount);
            request.setAttribute("unitPrice", unitPrice);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("paymentCode", expectedCode);
            request.setAttribute("codeError", "Mã xác nhận thanh toán không đúng. Vui lòng nhập lại.");
            request.getRequestDispatcher("/PaymentInterface4.jsp").forward(request, response);
            return;
        }

        // Mã xác nhận chỉ dùng được một lần cho đúng suất chiếu và đúng các ghế đã chọn.
        session.removeAttribute("paymentCode");
        session.removeAttribute("paymentShowtimeId");
        session.removeAttribute("paymentSeatIds");

        boolean saved = false;
        Invoice4 invoice = null;

        if (!invalidSeat) {
            invoice = new Invoice4();
            invoice.setCustomer(customer);
            invoice.setSalesStaff(null);
            invoice.setPaymentDate(new Timestamp(System.currentTimeMillis()));

            for (Seat4 seat : selectedSeats) {
                Ticket4 ticket = new Ticket4();
                ticket.setPrice(unitPrice);
                ticket.setStatus("DA_BAN");
                ticket.setShowtime(showtime);
                ticket.setSeat(seat);
                ticket.setCustomer(customer);
                invoice.getTickets().add(ticket);
            }

            InvoiceDAO4 invoiceDAO = new InvoiceDAO4();
            invoice.setTotalAmount(invoiceDAO.calculateTotalAmount4(invoice.getTickets()));
            saved = invoiceDAO.addInvoice4(invoice);
            if (saved) {
                invoiceDAO.printInvoice4();
            } else {
                // Có thể ghế vừa bị người khác đặt trong lúc thanh toán (ràng buộc UNIQUE).
                Set<Integer> soldNow = ticketDAO.getSoldSeatIds4(showtimeId);
                for (Seat4 seat : selectedSeats) {
                    if (soldNow.contains(seat.getId())) {
                        invalidSeat = true;
                        request.setAttribute("conflict",
                                "Một hoặc nhiều ghế vừa được người khác đặt. Vui lòng chọn lại ghế.");
                        break;
                    }
                }
            }
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
