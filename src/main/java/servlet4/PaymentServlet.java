package servlet4;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao4.MembershipCardDAO4;
import dao4.SeatDAO4;
import dao4.ShowtimeDAO4;
import dao4.TicketDAO4;
import model4.Seat4;
import model4.Showtime4;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

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

        String paymentCode = null;
        if (!invalidSeat) {
            paymentCode = String.format("%09d", new SecureRandom().nextInt(1_000_000_000));
            HttpSession session = request.getSession();
            session.setAttribute("paymentCode", paymentCode);
            session.setAttribute("paymentShowtimeId", showtimeId);
            session.setAttribute("paymentSeatIds", new TreeSet<>(selectedIds).toString());
        }

        request.setAttribute("showtime", showtime);
        request.setAttribute("selectedSeats", selectedSeats);
        request.setAttribute("cardId", cardIdText == null ? "" : cardIdText.trim());
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("unitPrice", unitPrice);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("paymentCode", paymentCode);
        request.setAttribute("invalidSeat", invalidSeat);
        request.getRequestDispatcher("/PaymentInterface4.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/movies");
    }
}
