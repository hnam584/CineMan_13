package model4;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Invoice4 {
    private String invoiceId;
    private double totalAmount;
    private Timestamp paymentDate;
    private int customerMemberId;
    private Integer employeeMemberId;
    private List<Ticket4> tickets = new ArrayList<>();

    public Invoice4() {}

    public String getInvoiceId() { return invoiceId; }
    public void setInvoiceId(String invoiceId) { this.invoiceId = invoiceId; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public Timestamp getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }

    public int getCustomerMemberId() { return customerMemberId; }
    public void setCustomerMemberId(int customerMemberId) { this.customerMemberId = customerMemberId; }

    public Integer getEmployeeMemberId() { return employeeMemberId; }
    public void setEmployeeMemberId(Integer employeeMemberId) { this.employeeMemberId = employeeMemberId; }

    public List<Ticket4> getTickets() { return tickets; }
    public void setTickets(List<Ticket4> tickets) { this.tickets = tickets; }
}
