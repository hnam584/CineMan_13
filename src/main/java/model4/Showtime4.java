package model4;

import java.sql.Timestamp;

/**
 * Lớp thực thể Showtime4 (tblShowtime4).
 */
public class Showtime4 {
    private int id;
    private Timestamp startTime;
    private Timestamp endTime;
    private float ticketPrice;

    /** Quan hệ Movie4 1 - n Showtime4. */
    private Movie4 movie;

    /** Quan hệ ScreeningRoom4 1 - n Showtime4. */
    private ScreeningRoom4 room;

    public Showtime4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public float getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(float ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public Movie4 getMovie() {
        return movie;
    }

    public void setMovie(Movie4 movie) {
        this.movie = movie;
    }

    public ScreeningRoom4 getRoom() {
        return room;
    }

    public void setRoom(ScreeningRoom4 room) {
        this.room = room;
    }
}
