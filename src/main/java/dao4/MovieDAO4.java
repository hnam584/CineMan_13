package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.Movie4;

public class MovieDAO4 extends DAO {

    public MovieDAO4() {
        super();
    }

    public boolean addMovie4(Movie4 movie) {
        String sql = "INSERT INTO tblMovie4 (movieId, movieName, description, genre, duration) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, movie.getMovieId());
            ps.setString(2, movie.getMovieName());
            ps.setString(3, movie.getDescription());
            ps.setString(4, movie.getGenre());
            ps.setInt(5, movie.getDuration());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Movie4> getAllMovies() {
        List<Movie4> list = new ArrayList<>();
        String sql = "SELECT * FROM tblMovie4";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Movie4 movie = new Movie4();
                movie.setMovieId(rs.getString("movieId"));
                movie.setMovieName(rs.getString("movieName"));
                movie.setDescription(rs.getString("description"));
                movie.setGenre(rs.getString("genre"));
                movie.setDuration(rs.getInt("duration"));
                list.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Movie4 getMovieById(String movieId) {
        String sql = "SELECT * FROM tblMovie4 WHERE movieId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, movieId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Movie4 movie = new Movie4();
                movie.setMovieId(rs.getString("movieId"));
                movie.setMovieName(rs.getString("movieName"));
                movie.setDescription(rs.getString("description"));
                movie.setGenre(rs.getString("genre"));
                movie.setDuration(rs.getInt("duration"));
                return movie;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateMovie(Movie4 movie) {
        String sql = "UPDATE tblMovie4 SET movieName=?, description=?, genre=?, duration=? WHERE movieId=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, movie.getMovieName());
            ps.setString(2, movie.getDescription());
            ps.setString(3, movie.getGenre());
            ps.setInt(4, movie.getDuration());
            ps.setString(5, movie.getMovieId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMovie(String movieId) {
        String sql = "DELETE FROM tblMovie4 WHERE movieId=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, movieId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}