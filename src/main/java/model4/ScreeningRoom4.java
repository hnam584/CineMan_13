package model4;

public class ScreeningRoom4 {
    private int id;
    private int capacity;

    private Manager4 manager;

    public ScreeningRoom4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public Manager4 getManager() {
        return manager;
    }

    public void setManager(Manager4 manager) {
        this.manager = manager;
    }

    public String getLabel() {
        return "P" + String.format("%02d", id);
    }
}
