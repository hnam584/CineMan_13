package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.Showtime4;

public class ShowtimeDAO4 extends DAO {

    public ShowtimeDAO4() {
        super();
    }

    private static final String BASE_SELECT =
            "SELECT s.id, s.showtimeId, s.startTime, s.endTime, s.ticketPrice, "
          + "m.movieId, r.roomId "
          + "FROM tblShowtime4 s "
          + "JOIN tblMovie4 m ON s.Movie4id = m.id "
          + "JOIN tblScreeningRoom4 r ON s.ScreeningRoom4id = r.id ";

    public List<Showtime4> getShowtimesByMovie4(String movieId) {
        List<Showtime4> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE m.movieId = ? ORDER BY s.startTime";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, movieId);
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

    public Showtime4 getShowtimeByCode(String showtimeId) {
        String sql = BASE_SELECT + "WHERE s.showtimeId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, showtimeId);
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
        Showtime4 s = new Showtime4();
        s.setId(rs.getInt("id"));
        s.setShowtimeId(rs.getString("showtimeId"));
        s.setStartTime(rs.getTimestamp("startTime"));
        s.setEndTime(rs.getTimestamp("endTime"));
        s.setTicketPrice(rs.getDouble("ticketPrice"));
        s.setMovieId(rs.getString("movieId"));
        s.setRoomId(rs.getString("roomId"));
        return s;
    }
}
