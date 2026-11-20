package model4;

/**
 * Lớp thực thể Seat4 (tblSeat4).
 */
public class Seat4 {
    private int id;
    private String status;

    /** Quan hệ ScreeningRoom4 1 - n Seat4. */
    private ScreeningRoom4 room;

    /** Nhãn hiển thị (không lưu CSDL), ví dụ A1, A2... */
    private String label;

    public Seat4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ScreeningRoom4 getRoom() {
        return room;
    }

    public void setRoom(ScreeningRoom4 room) {
        this.room = room;
    }

    public String getLabel() {
        if (label != null && !label.isEmpty()) {
            return label;
        }
        return "G" + id;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public boolean isAvailable() {
        return "TRONG".equalsIgnoreCase(status);
    }
}
