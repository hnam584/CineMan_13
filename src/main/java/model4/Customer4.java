package model4;

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
