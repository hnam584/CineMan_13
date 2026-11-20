package model4;

import java.sql.Date;

/**
 * Lớp thực thể MembershipCard4 (tblMembershipCard4).
 */
public class MembershipCard4 {
    private int id;
    private Date issueDate;
    private String status;

    /** Quan hệ SalesStaff4 1 - n MembershipCard4 (có thể null). */
    private SalesStaff4 salesStaff;

    public MembershipCard4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public SalesStaff4 getSalesStaff() {
        return salesStaff;
    }

    public void setSalesStaff(SalesStaff4 salesStaff) {
        this.salesStaff = salesStaff;
    }

    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }
}
