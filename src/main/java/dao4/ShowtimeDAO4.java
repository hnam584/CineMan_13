package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.Movie4;
import model4.ScreeningRoom4;
import model4.Showtime4;

/**
 * DAO cho lớp thực thể Showtime4.
 */
public class ShowtimeDAO4 extends DAO {

    private static final String BASE_SELECT =
            "SELECT s.id, s.startTime, s.endTime, s.ticketPrice, "
          + "m.id AS movieId, m.movieName, m.genre, m.duration, m.description, "
          + "r.id AS roomId, r.capacity "
          + "FROM tblShowtime4 s "
          + "JOIN tblMovie4 m ON s.tblMovie4id = m.id "
          + "JOIN tblScreeningRoom4 r ON s.tblScreeningRoom4id = r.id ";

    public ShowtimeDAO4() {
        super();
    }

    public List<Showtime4> getShowtimesByMovie4(int idMovie) {
        List<Showtime4> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE m.id = ? AND s.endTime >= NOW() ORDER BY s.startTime";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idMovie);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Showtime4 getShowtimeById4(int id) {
        String sql = BASE_SELECT + "WHERE s.id = ? AND s.endTime >= NOW()";
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

    private Showtime4 map(ResultSet rs) throws Exception {
        Showtime4 showtime = new Showtime4();
        showtime.setId(rs.getInt("id"));
        showtime.setStartTime(rs.getTimestamp("startTime"));
        showtime.setEndTime(rs.getTimestamp("endTime"));
        showtime.setTicketPrice(rs.getFloat("ticketPrice"));

        Movie4 movie = new Movie4();
        movie.setId(rs.getInt("movieId"));
        movie.setMovieName(rs.getString("movieName"));
        movie.setGenre(rs.getString("genre"));
        movie.setDuration(rs.getInt("duration"));
        movie.setDescription(rs.getString("description"));
        showtime.setMovie(movie);

        ScreeningRoom4 room = new ScreeningRoom4();
        room.setId(rs.getInt("roomId"));
        room.setCapacity(rs.getInt("capacity"));
        showtime.setRoom(room);
        return showtime;
    }
}
