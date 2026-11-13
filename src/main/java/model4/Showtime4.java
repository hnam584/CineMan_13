package model4;

import java.sql.Timestamp;

public class Showtime4 {
    private int id;
    private String showtimeId;
    private Timestamp startTime;
    private Timestamp endTime;
    private String movieId;
    private String roomId;
    private double ticketPrice;

    public Showtime4() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getShowtimeId() { return showtimeId; }
    public void setShowtimeId(String showtimeId) { this.showtimeId = showtimeId; }

    public Timestamp getStartTime() { return startTime; }
    public void setStartTime(Timestamp startTime) { this.startTime = startTime; }

    public Timestamp getEndTime() { return endTime; }
    public void setEndTime(Timestamp endTime) { this.endTime = endTime; }

    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }

    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }

    public double getTicketPrice() { return ticketPrice; }
    public void setTicketPrice(double ticketPrice) { this.ticketPrice = ticketPrice; }
}
