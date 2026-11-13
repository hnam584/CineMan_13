package model4;

public class Ticket4 {
    private String ticketId;
    private double price;
    private int seatId;
    private int showtimeId;
    private String seatCode;
    private String showtimeCode;

    public Ticket4() {}

    public String getTicketId() { return ticketId; }
    public void setTicketId(String ticketId) { this.ticketId = ticketId; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getSeatId() { return seatId; }
    public void setSeatId(int seatId) { this.seatId = seatId; }

    public int getShowtimeId() { return showtimeId; }
    public void setShowtimeId(int showtimeId) { this.showtimeId = showtimeId; }

    public String getSeatCode() { return seatCode; }
    public void setSeatCode(String seatCode) { this.seatCode = seatCode; }

    public String getShowtimeCode() { return showtimeCode; }
    public void setShowtimeCode(String showtimeCode) { this.showtimeCode = showtimeCode; }
}
