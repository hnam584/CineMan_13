package model4;

public class Seat4 {
    private int id;
    private String seatId;
    private String status;
    private String roomId;

    public Seat4() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSeatId() { return seatId; }
    public void setSeatId(String seatId) { this.seatId = seatId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }

    public boolean isAvailable() {
        return "TRONG".equalsIgnoreCase(status);
    }
}
