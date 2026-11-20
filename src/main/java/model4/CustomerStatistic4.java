package model4;

/**
 * Lớp thống kê khách hàng (không có bảng riêng, dữ liệu dẫn xuất).
 * Kế thừa Customer4 theo thiết kế.
 */
public class CustomerStatistic4 extends Customer4 {
    private int numberOfCustomers;

    public int getNumberOfCustomers() {
        return numberOfCustomers;
    }

    public void setNumberOfCustomers(int numberOfCustomers) {
        this.numberOfCustomers = numberOfCustomers;
    }
}
