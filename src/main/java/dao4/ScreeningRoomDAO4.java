package dao4;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model4.ScreeningRoom4;

public class ScreeningRoomDAO4 extends DAO {

    public ScreeningRoomDAO4() {
        super();
    }

    public ScreeningRoom4 getRoomById4(String roomId) {
        String sql = "SELECT id, roomId, capacity FROM tblScreeningRoom4 WHERE roomId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ScreeningRoom4 room = new ScreeningRoom4();
                    room.setId(rs.getInt("id"));
                    room.setRoomId(rs.getString("roomId"));
                    room.setCapacity(rs.getInt("capacity"));
                    return room;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
