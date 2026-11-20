package model4;

/**
 * Lớp thực thể Employee4 (tblEmployee4) - kế thừa Member4, thêm vị trí công việc.
 */
public class Employee4 extends Member4 {
    private String position;

    public Employee4() {
        super();
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
