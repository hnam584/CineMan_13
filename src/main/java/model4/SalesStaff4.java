package model4;

/**
 * Lớp thực thể SalesStaff4 (tblSalesStaff4) - nhân viên bán hàng.
 */
public class SalesStaff4 extends Employee4 {

    public SalesStaff4() {
        super();
        this.setPosition("Sales Staff");
        this.setRole("SALES_STAFF");
    }
}
