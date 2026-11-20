package model4;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Lớp thực thể Invoice4 (tblInvoice4).
 */
public class Invoice4 {
    private int id;
    private float totalAmount;
    private Timestamp paymentDate;

    /** Quan hệ Invoice4 1 - n Ticket4. */
    private List<Ticket4> tickets = new ArrayList<>();

    /** Quan hệ Customer4 1 - n Invoice4. */
    private Customer4 customer;

    /** Quan hệ SalesStaff4 1 - n Invoice4 (có thể null với hóa đơn online). */
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

    /** Mã hóa đơn hiển thị (sinh từ id, không lưu CSDL). */
    public String getCode() {
        return String.format("HD%06d", id);
    }
}
