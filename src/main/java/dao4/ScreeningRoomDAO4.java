package dao4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model4.Manager4;
import model4.ScreeningRoom4;

/**
 * DAO cho lớp thực thể ScreeningRoom4.
 */
public class ScreeningRoomDAO4 extends DAO {

    public ScreeningRoomDAO4() {
        super();
    }

    public ScreeningRoom4 getRoomById4(int id) {
        String sql = "SELECT id, capacity, tblManager4tblEmployee4tblMember4id "
                   + "FROM tblScreeningRoom4 WHERE id = ?";
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

    public List<ScreeningRoom4> getAllRooms4() {
        List<ScreeningRoom4> list = new ArrayList<>();
        String sql = "SELECT id, capacity, tblManager4tblEmployee4tblMember4id "
                   + "FROM tblScreeningRoom4 ORDER BY id";
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

    public boolean addRoom4(ScreeningRoom4 room) {
        String sql = "INSERT INTO tblScreeningRoom4 "
                   + "(capacity, tblManager4tblEmployee4tblMember4id) VALUES (?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, room.getCapacity());
            if (room.getManager() == null) {
                ps.setNull(2, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, room.getManager().getId());
            }
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private ScreeningRoom4 map(ResultSet rs) throws Exception {
        ScreeningRoom4 room = new ScreeningRoom4();
        room.setId(rs.getInt("id"));
        room.setCapacity(rs.getInt("capacity"));

        int managerId = rs.getInt("tblManager4tblEmployee4tblMember4id");
        if (!rs.wasNull()) {
            Manager4 manager = new Manager4();
            manager.setId(managerId);
            room.setManager(manager);
        }
        return room;
    }
}
