package model4;

public class Seat4 {
    private int id;
    private String status;

    private ScreeningRoom4 room;

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
