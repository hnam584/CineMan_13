package servlet4;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao4.MovieDAO4;
import model4.Movie4;

@WebServlet("/movies")
public class MovieCatalogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MovieDAO4 movieDAO = new MovieDAO4();
        List<Movie4> movies = movieDAO.getAllMovies4();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/ListMovieInterface4.jsp").forward(request, response);
    }
}
