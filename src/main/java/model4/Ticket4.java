package model4;

import java.sql.Timestamp;

/**
 * Lớp thực thể Ticket4 (tblTicket4).
 */
public class Ticket4 {
    private int id;
    private float price;
    private String status;
    private Timestamp holdUntil;

    /** Quan hệ Showtime4 1 - n Ticket4. */
    private Showtime4 showtime;

    /** Quan hệ Seat4 1 - n Ticket4. */
    private Seat4 seat;

    /** Quan hệ Customer4 1 - n Ticket4. */
    private Customer4 customer;

    public Ticket4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getHoldUntil() {
        return holdUntil;
    }

    public void setHoldUntil(Timestamp holdUntil) {
        this.holdUntil = holdUntil;
    }

    public Showtime4 getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime4 showtime) {
        this.showtime = showtime;
    }

    public Seat4 getSeat() {
        return seat;
    }

    public void setSeat(Seat4 seat) {
        this.seat = seat;
    }

    public Customer4 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer4 customer) {
        this.customer = customer;
    }
}
