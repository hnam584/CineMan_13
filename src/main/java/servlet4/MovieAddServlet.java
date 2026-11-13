package servlet4;

import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao4.MovieDAO4;
import model4.Movie4;

@WebServlet("/add-movie")
public class MovieAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/AddMovieInterface4.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("inName");
        String genre = request.getParameter("inGenre");
        String durationText = request.getParameter("inDuration");
        String description = request.getParameter("inDescription");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên phim.");
            request.getRequestDispatcher("/AddMovieInterface4.jsp").forward(request, response);
            return;
        }

        int duration;
        try {
            duration = Integer.parseInt(durationText);
            if (duration <= 0) {
                throw new NumberFormatException();
            }
        } catch (Exception e) {
            request.setAttribute("error", "Thời lượng phải là số nguyên dương.");
            request.getRequestDispatcher("/AddMovieInterface4.jsp").forward(request, response);
            return;
        }

        String movieId = "M" + UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase();
        Movie4 movie = new Movie4(movieId, name.trim(), genre, duration, description);
        MovieDAO4 movieDAO = new MovieDAO4();
        boolean added = movieDAO.addMovie4(movie);

        if (added) {
            request.setAttribute("success", "Thêm phim thành công.");
        } else {
            request.setAttribute("error", "Thêm phim thất bại. Vui lòng thử lại.");
        }
        request.getRequestDispatcher("/AddMovieInterface4.jsp").forward(request, response);
    }
}
