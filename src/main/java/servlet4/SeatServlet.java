package servlet4;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao4.SeatDAO4;
import dao4.ShowtimeDAO4;
import model4.Seat4;
import model4.Showtime4;

@WebServlet("/seats")
public class SeatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String showtimeId = request.getParameter("showtimeId");
        if (showtimeId == null || showtimeId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        ShowtimeDAO4 showtimeDAO = new ShowtimeDAO4();
        Showtime4 showtime = showtimeDAO.getShowtimeByCode(showtimeId);
        if (showtime == null) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        SeatDAO4 seatDAO = new SeatDAO4();
        List<Seat4> seats = seatDAO.getSeatsByShowtime4(showtimeId);
        request.setAttribute("showtime", showtime);
        request.setAttribute("seats", seats);
        request.getRequestDispatcher("/SeatInterface4.jsp").forward(request, response);
    }
}
