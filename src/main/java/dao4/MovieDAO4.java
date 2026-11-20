package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.Manager4;
import model4.Movie4;

public class MovieDAO4 extends DAO {

    private static final String SELECT_ALL =
            "SELECT id, movieName, description, genre, duration, "
          + "tblManager4tblEmployee4tblMember4id FROM tblMovie4 ";

    public MovieDAO4() {
        super();
    }

    public boolean addMovie4(Movie4 movie) {
        String sql = "INSERT INTO tblMovie4 "
                   + "(movieName, description, genre, duration, tblManager4tblEmployee4tblMember4id) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, movie.getMovieName());
            ps.setString(2, movie.getDescription());
            ps.setString(3, movie.getGenre());
            ps.setInt(4, movie.getDuration());
            if (movie.getManager() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, movie.getManager().getId());
            }
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateMovie4(Movie4 movie) {
        String sql = "UPDATE tblMovie4 SET movieName=?, description=?, genre=?, duration=? WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, movie.getMovieName());
            ps.setString(2, movie.getDescription());
            ps.setString(3, movie.getGenre());
            ps.setInt(4, movie.getDuration());
            ps.setInt(5, movie.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMovie4(int id) {
        String sql = "DELETE FROM tblMovie4 WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Movie4 getMovieById4(int id) {
        String sql = SELECT_ALL + "WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Movie4> getAllMovies4() {
        List<Movie4> list = new ArrayList<>();
        String sql = SELECT_ALL + "ORDER BY movieName";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Movie4 map(ResultSet rs) throws Exception {
        Movie4 movie = new Movie4();
        movie.setId(rs.getInt("id"));
        movie.setMovieName(rs.getString("movieName"));
        movie.setDescription(rs.getString("description"));
        movie.setGenre(rs.getString("genre"));
        movie.setDuration(rs.getInt("duration"));

        int managerId = rs.getInt("tblManager4tblEmployee4tblMember4id");
        if (!rs.wasNull()) {
            Manager4 manager = new Manager4();
            manager.setId(managerId);
            movie.setManager(manager);
        }
        return movie;
    }
}
