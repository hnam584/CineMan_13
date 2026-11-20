package model4;

/**
 * Lớp thống kê doanh thu (không có bảng riêng, dữ liệu dẫn xuất).
 * Kế thừa Invoice4 theo thiết kế.
 */
public class RevenueStatistic4 extends Invoice4 {
    private float totalRevenue;

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
