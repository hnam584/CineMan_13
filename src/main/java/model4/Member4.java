package model4;

import java.util.Date;

/**
 * Lớp thực thể Member4 (tblMember4).
 * Các lớp Employee4 và Customer4 kế thừa từ lớp này.
 */
public class Member4 {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private Date dateOfBirth;
    private String email;
    private String phone;
    private String address;

    /** Thuộc tính không lưu CSDL: vai trò dùng cho phân quyền. */
    private String role;

    public Member4() {
    }

    public Member4(String username, String password, String fullName,
                   Date dateOfBirth, String email, String phone, String address) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRoleLabel() {
        if ("MANAGER".equals(role)) {
            return "Nhân viên quản lý";
        }
        if ("SALES_STAFF".equals(role)) {
            return "Nhân viên bán hàng";
        }
        if ("CUSTOMER".equals(role)) {
            return "Khách hàng";
        }
        return "Thành viên";
    }

    public boolean isManager() {
        return "MANAGER".equals(role);
    }

    public boolean isCustomer() {
        return "CUSTOMER".equals(role);
    }

    public boolean isSalesStaff() {
        return "SALES_STAFF".equals(role);
    }
}
