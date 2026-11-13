package model4;

import java.sql.Date;

public class MembershipCard4 {
    private int id;
    private String cardId;
    private Date issueDate;
    private String status;
    private int customerMemberId;

    public MembershipCard4() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCardId() { return cardId; }
    public void setCardId(String cardId) { this.cardId = cardId; }

    public Date getIssueDate() { return issueDate; }
    public void setIssueDate(Date issueDate) { this.issueDate = issueDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCustomerMemberId() { return customerMemberId; }
    public void setCustomerMemberId(int customerMemberId) { this.customerMemberId = customerMemberId; }

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }
}
