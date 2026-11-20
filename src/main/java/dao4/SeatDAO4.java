package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.ScreeningRoom4;
import model4.Seat4;

/**
 * DAO cho lớp thực thể Seat4.
 */
public class SeatDAO4 extends DAO {

    public SeatDAO4() {
        super();
    }

    /**
     * Lấy danh sách ghế của một phòng chiếu.
     * Nhãn ghế được sinh theo thứ tự (A1..A10, B1..B10...) để hiển thị.
     */
    public List<Seat4> getSeatsByRoom4(int idRoom) {
        List<Seat4> list = new ArrayList<>();
        String sql = "SELECT id, status, tblScreeningRoom4id "
                   + "FROM tblSeat4 WHERE tblScreeningRoom4id = ? ORDER BY id";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idRoom);
            try (ResultSet rs = ps.executeQuery()) {
                int index = 0;
                while (rs.next()) {
                    Seat4 seat = new Seat4();
                    seat.setId(rs.getInt("id"));
                    seat.setStatus(rs.getString("status"));

                    ScreeningRoom4 room = new ScreeningRoom4();
                    room.setId(rs.getInt("tblScreeningRoom4id"));
                    seat.setRoom(room);

                    char row = (char) ('A' + (index / 10));
                    int number = (index % 10) + 1;
                    seat.setLabel(row + String.valueOf(number));
                    index++;
                    list.add(seat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Seat4 getSeatById4(int id) {
        String sql = "SELECT id, status, tblScreeningRoom4id FROM tblSeat4 WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Seat4 seat = new Seat4();
                    seat.setId(rs.getInt("id"));
                    seat.setStatus(rs.getString("status"));

                    ScreeningRoom4 room = new ScreeningRoom4();
                    room.setId(rs.getInt("tblScreeningRoom4id"));
                    seat.setRoom(room);
                    return seat;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSeatStatus4(int idSeat, String status) {
        String sql = "UPDATE tblSeat4 SET status = ? WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, idSeat);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
