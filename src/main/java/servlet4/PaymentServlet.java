package servlet4;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao4.MembershipCardDAO4;
import dao4.SeatDAO4;
import dao4.ShowtimeDAO4;
import model4.MembershipCard4;
import model4.Seat4;
import model4.Showtime4;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
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

        MembershipCard4 card = null;
        boolean appliedDiscount = false;
        if (loyaltyCode != null && !loyaltyCode.trim().isEmpty()) {
            MembershipCardDAO4 cardDAO = new MembershipCardDAO4();
            card = cardDAO.getByCardId(loyaltyCode.trim());
            appliedDiscount = card != null && card.isActive();
        }

        double discountRate = appliedDiscount ? 0.10 : 0.0;
        double unitPrice = showtime.getTicketPrice() * (1 - discountRate);
        double totalAmount = unitPrice * selectedSeats.size();

        request.setAttribute("showtime", showtime);
        request.setAttribute("selectedSeats", selectedSeats);
        request.setAttribute("loyaltyCode", loyaltyCode == null ? "" : loyaltyCode.trim());
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("unitPrice", unitPrice);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("invalidSeat", invalidSeat);
        request.getRequestDispatcher("/PaymentInterface4.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/movies");
    }
}
