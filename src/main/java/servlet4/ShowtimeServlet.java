package servlet4;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao4.MovieDAO4;
import dao4.ShowtimeDAO4;
import model4.Movie4;
import model4.Showtime4;

@WebServlet("/showtimes")
public class ShowtimeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId;
        try {
            movieId = Integer.parseInt(request.getParameter("movieId"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        MovieDAO4 movieDAO = new MovieDAO4();
        Movie4 movie = movieDAO.getMovieById4(movieId);
        if (movie == null) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        ShowtimeDAO4 showtimeDAO = new ShowtimeDAO4();
        List<Showtime4> showtimes = showtimeDAO.getShowtimesByMovie4(movieId);

        request.setAttribute("movie", movie);
        request.setAttribute("showtimes", showtimes);
        request.getRequestDispatcher("/ShowtimeInterface4.jsp").forward(request, response);
    }
}
