package model4;

/**
 * Lớp thực thể Customer4 (tblCustomer4) - kế thừa Member4, giữ mã khách hàng.
 */
public class Customer4 extends Member4 {
    private String customerId;

    public Customer4() {
        super();
        this.setRole("CUSTOMER");
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }
}
