<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cinema Interface 4</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .container { border: 2px solid #000; width: 750px; padding: 15px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .header-btn { border: 1px solid #000; padding: 6px 15px; background: #fff; text-decoration: none; color: #000; }
        .main-layout { display: flex; border: 1px solid #000; min-height: 260px; }
        .sidebar { width: 35%; border-right: 1px solid #000; display: flex; flex-direction: column; }
        .sidebar-btn { border: none; border-bottom: 1px solid #000; padding: 15px; background: #fff; text-align: center; text-decoration: none; color: #000; font-size: 14px; }
        .sidebar-btn.active { background-color: #ffff00; font-weight: bold; }
        .sidebar-btn.disabled { color: #888; cursor: not-allowed; }
        .sidebar-btn:last-child { border-bottom: none; }
        .content { width: 65%; display: flex; align-items: center; justify-content: center; text-align: center; padding: 20px; }
        .notice { color: #b00000; font-weight: bold; }
    </style>
</head>
<body>
<c:set var="member" value="${sessionScope.member}"/>
<div class="container">
    <h3 style="text-align: center; margin-top: 0;">Cinema Interface 4</h3>
    <div class="header">
        <span class="header-btn">Xin chào, <c:out value="${member.fullName}"/> (<c:out value="${member.roleLabel}"/>)</span>
        <a href="${pageContext.request.contextPath}/logout" class="header-btn">Đăng xuất</a>
    </div>

    <c:choose>
        <c:when test="${member.role == 'MANAGER'}">
            <div class="main-layout">
                <div class="sidebar">
                    <span class="sidebar-btn disabled">Quản lí lịch chiếu</span>
                    <a href="${pageContext.request.contextPath}/manage-movies" class="sidebar-btn active">Quản lí phim</a>
                    <span class="sidebar-btn disabled">Quản lí phòng chiếu</span>
                    <span class="sidebar-btn disabled">Thống kê</span>
                </div>
                <div class="content">
                    <h3>Chào mừng đến với hệ thống Cineman</h3>
                </div>
            </div>
        </c:when>

        <c:when test="${member.role == 'CUSTOMER'}">
            <div class="main-layout">
                <div class="sidebar">
                    <a href="${pageContext.request.contextPath}/movies" class="sidebar-btn active">Mua vé trực tuyến</a>
                    <span class="sidebar-btn disabled">Đăng kí thành viên</span>
                    <span class="sidebar-btn disabled">Tìm kiếm</span>
                </div>
                <div class="content">
                    <h3>Chào mừng đến với Cineman</h3>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="main-layout">
                <div class="sidebar">
                    <span class="sidebar-btn disabled">Bán vé tại quầy</span>
                    <span class="sidebar-btn disabled">Xuất thẻ thành viên</span>
                </div>
                <div class="content">
                    <p class="notice">Chức năng bán vé tại quầy chưa được cài đặt trong phiên bản demo.<br/>
                    Vui lòng đăng nhập bằng tài khoản khách hàng để mua vé trực tuyến.</p>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
