package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.Seat4;

public class SeatDAO4 extends DAO {

    public SeatDAO4() {
        super();
    }

    /**
     * Trả về ghế của phòng chiếu ứng với suất chiếu.
     * Trạng thái được tính từ bảng vé: ghế đã có vé cho suất này là DA_BAN.
     */
    public List<Seat4> getSeatsByShowtime4(String showtimeId) {
        List<Seat4> list = new ArrayList<>();
        String sql =
                "SELECT se.id, se.seatId, se.status, r.roomId, "
              + "CASE WHEN t.id IS NULL THEN 'TRONG' ELSE 'DA_BAN' END AS availability "
              + "FROM tblSeat4 se "
              + "JOIN tblScreeningRoom4 r ON se.ScreeningRoom4id = r.id "
              + "JOIN tblShowtime4 s ON s.ScreeningRoom4id = r.id "
              + "LEFT JOIN tblTicket4 t ON t.Seat4id = se.id AND t.ShowTime4id = s.id "
              + "WHERE s.showtimeId = ? "
              + "ORDER BY se.seatId";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat4 seat = new Seat4();
                    seat.setId(rs.getInt("id"));
                    seat.setSeatId(rs.getString("seatId"));
                    seat.setStatus(rs.getString("availability"));
                    seat.setRoomId(rs.getString("roomId"));
                    list.add(seat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Seat4 getSeatById(int id) {
        String sql =
                "SELECT se.id, se.seatId, se.status, r.roomId "
              + "FROM tblSeat4 se "
              + "JOIN tblScreeningRoom4 r ON se.ScreeningRoom4id = r.id "
              + "WHERE se.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Seat4 seat = new Seat4();
                    seat.setId(rs.getInt("id"));
                    seat.setSeatId(rs.getString("seatId"));
                    seat.setStatus(rs.getString("status"));
                    seat.setRoomId(rs.getString("roomId"));
                    return seat;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSeatStatus4(int seatId, String status) {
        String sql = "UPDATE tblSeat4 SET status = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, seatId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
