package model4;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Invoice4 {
    private int id;
    private float totalAmount;
    private Timestamp paymentDate;

    private List<Ticket4> tickets = new ArrayList<>();

    private Customer4 customer;

    private SalesStaff4 salesStaff;

    public Invoice4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public List<Ticket4> getTickets() {
        return tickets;
    }

    public void setTickets(List<Ticket4> tickets) {
        this.tickets = tickets;
    }

    public Customer4 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer4 customer) {
        this.customer = customer;
    }

    public SalesStaff4 getSalesStaff() {
        return salesStaff;
    }

    public void setSalesStaff(SalesStaff4 salesStaff) {
        this.salesStaff = salesStaff;
    }

    public String getCode() {
        return String.format("HD%06d", id);
    }
}
